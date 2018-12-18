function log = getLogTextStruct()
% getLogTextStruct  Return a structure containing lines to be printed to
% create the log file at the end of the preprocessing. Each line
% corresponds to a specific step of preprocessing and is printed if that
% specific preprocessing step is used.
%
%   Simply change the text here and the log file will be changed
%   accordingly.
%
%   The text is hardcoded and need to be changed accordingly if anything in
%   the preprocessing steps is changed.
%
% Copyright (C) 2018  Amirreza Bahreini, amirreza.bahreini@uzh.ch
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

log = struct('info', struct('automagic', 'Automagic version %s\n',...
                            'matlab', 'MATLAB version %s, Release %s %s\n', ...
                            'fileName', 'File %s of subject %s belongs to study %s\n', ...
                            'time', 'Last time preprocessed: %s\n'), ...
            'error', struct('desc', '>>>>>>>>>>>>>>> An unusual ERROR on this file has occurred: %s\n'), ...
            'prep', struct('desc', '* PREP pipeline (Bigdely-Shamlo N, Mullen T, Kothe C, Su K-M and Robbins KA (2015))\n', ...
                           'detrend', '\t* Temporary (not affecting final EEG) detrend data at %.2f Hz cutoff \n\t (%.2f s window slide) using using %s detrending to improve \n\t performance of down-stream processing. In the case of high pass \n\t filtering the pop_eegfiltnew FIR filter is used.\n',...
                           'lineNoise', '\t* Line noise removal, using routines from the cleanline EEGLAB plugin \n\t with a frequency range of [%.2f %.2f] Hz, where %sHz \n\t (+- %d Hz bandwith) are tried to be removed in maximally %d iterations. \n\t (Mullen, T. (2012). NITRC: CleanLine: Tool/Resource Info. Available \n\t  online at: http://www.nitrc.org/projects/cleanline)\n',...
                           'reference', struct('robDevThres', '\t* Detecting noisy or outlier channels based on extreme amplitudes \n\t of a Z-score cutoff for robust channel deviation of more than %.2f.\n', ...
                                                'corr', '\t* Detecting noisy or outlier channels based on lack of correlation \n\t with any other channel with a window size of %d s to compute \n\t correlations and a threshold of %.2f (the lowest maximum correlation \n\t with another channel).\n',...
                                                'ransac', '\t* Detecting noisy or outlier channels based on lack of predictability \n\t by other channels using a RANSAC sample size of %d in a fraction of \n\t %.2f evaluation channels to predict a channel. Channels are bad if \n\t the RANSAC prediction in a fraction of %.2f windows of %.2fs duration \n\t falls below the absolute correlation of %.2f.\n',...
                                                'highFreqNoise', '\t* Detecting noisy or outlier channels based on unusual high frequency \n\t noise using a Z-score cutoff for SNR (signal above 50* Hz) of %.2f.\n', ...
                                                'maxIter', '\t* Robust referencing using maximally %.2f.\n'...
                                                )...
                        ),...
             'clean_rawdata', struct('desc', '* clean_rawdata() 0.34 (by Christian Kothe http://sccn.ucsd.edu/wiki/Plugin_list_process)\n', ...
                                     'noASRFilter', '\t* Temporary (not affecting final data) detrend data with a high pass filter \n\t (forward-backward (non-causal) filter) with a transition band of \n\t [%.2f %.2f] (stop-band attenuation of 80*dB)\n', ...
                                     'ASRFilter', '\t* Detrend data (affecting final data) with a high pass filter \n\t (forward-backward (non-causal)  filter) with a transition band of \n\t [%.2f %.2f] (stop-band attenuation of 80*dB)\n', ...
                                     'flatLine', '\t* Detecting (near-) flat-lined channels with a maximally tolerated \n\t duration of %.2f s and a maximum tolerated jitter during flatlines \n\t of 20x epsilon (i.e. floating-point relative accuracy).\n', ...
                                     'lineNoise', '\t* Detecting noisy or outlier channels based on exceeding noise level \n\t of more than %.2f standard deviations compared to the total channel \n\t population\n', ...
                                     'ransac', '\t* Detecting noisy or outlier channels based on lack of predictability \n\t by other channels using a RANSAC sample size of 50 in a fraction of \n\t 0.25 evaluation channels to predict a channel. Channels are bad if \n\t the RANSAC prediction in a fraction of %.2f windows of 5* s duration falls \n\t below the absolute correlation of %.2f.\n', ...
                                     'burst','\t* Reconstructing epochs of the EEG that are contaminated abnormally \n\t strong power (more than %.2f SD relative to calibration data) using \n\t Artifact Subspace Reconstruction (REFERENCE). The subspaces on which \n\t those events occur are reconstructed (interpolated) based on the rest \n\t of the EEG signal during these time periods.\n',...
                                     'window','\t* Time windows are removed that were not repaired completely if the \n\t maximum number of channels is greater than %.2f.\n'...
                        ),...
             'filtering', struct('desc', '* pop_eegfiltnew() of EEGLAB (Widmann A, Schröger E. Filter effects and filter \n\t artifacts in the analysis of electrophysiological data. Frontiers in \n\t psychology. 2012 Jul;3:233)\n', ...
                                 'high', '\t* Performed a high pass filter using pop_eegfiltnew() FIR filter with \n\t passband edge(s): %.2fHz, filter order: %.2f, transition band width: %.2fHz.\n', ...
                                 'low', '\t* Performed a low pass filter using pop_eegfiltnew() FIR filter with \n\t passband edge(s): %.2fHz, filter order: %.2f, transition band width: %.2fHz.\n', ...
                                 'notch', '\t* Performed a bandpass filter using pop_eegfiltnew() FIR filter with \n\t passband edge(s): %.2fHz, filter order: %.2f, transition band width: %.2fHz.\n' ...
                        ),...
              'badchans', struct('desc', '* Removing a total of %d noisy or outlier channels\n', ...
                                 'prep', '\t* Number of channels removed due to PREP: %d\n', ...
                                 'crd', '\t* Number of channels removed due to clean_rawdata(): %d\n', ...
                                 'flatline', '\t* Number of channels removed due to being flatlines: %d\n' ...
                        ),...
               'eog', struct('desc', '* Remove the effect of EOG using linear analysis  (Parra, L. C., Spence, C. D., Gerson, A. D., & Sajda, P. (2005). Recipes for the linear analysis of EEG. Neuroimage, 28(2), 326-341.)\n' ...
                        ),...
               'mara', struct('desc', '* Automatic classification and removal of artifactual source components using \n\t Multiple Artifact Rejection Algorithm (MARA) (Winkler, I., Haufe \n\t , S., & Tangermann, M. (2011). Automatic classification of artifactual \n\t ICA-components for artifact removal in EEG signals. Behavioral and \n\t Brain Functions, 7(1), 30.)\n', ...
                             'filtering', '\t* Performed a temporary (not affecting final data) high pass filter using \n\t  pop_eegfiltnew() FIR filter  with passband edge(s): %.2fHz, \n\t filter order: %.2f, transition band width:  %.2fHz.\n', ...
                             'reject', '\t* Run an ICA decomposition of an EEG dataset using the EEGLAB function \n\t runica(), removing %d, while retaining %.2f %% Variance.\n', ...
                             'remove', '\t* Automatic classification of multiple artifact components based on \n\t 6 features from the time domain, the frequency domain, and the pattern\n\t* Remove classified components and subtract their activities from the \n\t (not temporarily filtered) data\n' ...
                        ),...
               'rpca', struct('desc', '* Remove DC offset by subtracting the channel mean\n',...
                             'params', '\t* The weight on sparse error term in the cost function is 1 / sqrt(numChans) or if not default  %.4f with a tolerance %.4f of for stopping criterion and a maximum number of %d iterations\n'...
                        ),...
               'dc', struct('desc', '* Remove DC offset by subtracting the channel mean\n' ...
                             ),...
               'highvar', struct('desc', '* Identify remaining noisy or outlier channels based on a higher variance than %.2f\n' ...
                             ),...
               'interpolate', struct('desc', '* Interpolate noisy or outlier channels using eeg_interp() with %s method\n' ...
                             ),...
               'quality', struct('OHA', '* Calculate quality measures with Overall thresholds of %s, ',...
                                 'THV','time thresholds of %s, ', ... 
                                 'CHV', 'channel thresholds of %s\n' ...
                             )...
                    );
                

end