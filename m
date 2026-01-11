Return-Path: <linux-acpi+bounces-20151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB7D0E133
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 05:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F1530124DA
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E821B9D2;
	Sun, 11 Jan 2026 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7eFud5L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052791EFF93
	for <linux-acpi@vger.kernel.org>; Sun, 11 Jan 2026 04:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768107228; cv=none; b=AZuu6M/wknqJg7rURVLSXm27R7HplYeMRv6DwllNzAwHYzjnQtUQX4YZTeustmEMGyVsME0nrxsZ9nUoWQQKJuvhPBT0S1RjLm9yHLPVyunSOEDwWLHEVkWHfkzePt65Y/9XGk5z860bUIf6f1iJRtSzTAZXvxbVzMfyVgR1YYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768107228; c=relaxed/simple;
	bh=FKIKTBZ0GsN4rm/M9grFO1cXmdRTqeRGz0314M/ltwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tea27kcPZIfYH8fh8eOnmfw4plPwyhP7/0uR8FvgQbhkit8xL5Szi0U3jzJI/wnxkNRQ4h6j1zAoWuvVDKoB5DwI6tkc6dXZrLEY1GtWQ1inMwmZRqMvoK3P97KxbF1xV6QwSmFxvH4IYeCKzq3jsigGfWdmBvBvOqN+clVhXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7eFud5L; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6442e2dd8bbso4232403d50.0
        for <linux-acpi@vger.kernel.org>; Sat, 10 Jan 2026 20:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768107226; x=1768712026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRTKAtfTpzFTDAQuznCEfe1KGiZpT38bizObLyToCRI=;
        b=V7eFud5LrfrkgwNVlMeICyRuXe2QrvWQ/S7dyAzTvjvemj5+QUaZWaA5VgrAh0KcIB
         eLlc76qA4MAAxzVTrLwHxkBsj491CDgsg+rD4ctHaleCH8iwoupOqAoU7BfMO/kdh0/7
         Wsk7Z+PkN413IdNew4pu/kCws46l5bndSC7IbruRQvWYCW/vUEQBNvlUZjZHE9ETB0qW
         AeafvioZ8Bxp68YKWGGFNDd19AUfBYjMIUJU8kilEuVToPfmFv7AyRTi703YjjKBEbcb
         nHTkh7Uw0UHsjffry/sgoS420DOs/Ouf8SYb3vexhMItcmkLXuOmEg28C9yA8aCV3K7D
         4Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768107226; x=1768712026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRTKAtfTpzFTDAQuznCEfe1KGiZpT38bizObLyToCRI=;
        b=NCUb46c6qqciyszjU0Cb+sN9j4gWrgXel+04lGlY42iv5rUmx3GuWDXPIKiGiBHPMi
         43OTBcPnwxxrVj4GziVXHCnjCshrkjZ5IZp13RJ31KUDd9SLro7v+l7vKqToK693zc3e
         KDzDG3dGacaBTsDbvxhDbvR1jc0XTHt01J9qZud8Jbltpno6aL6KPWI2x4DuDYe9cnsT
         73SiF7mQFSzeDMvzB8Yqw0Y6B43HPzTG2J2FA6ak0FHfNpvxclgZ3n1PL40u3nN67NqT
         om5Y8pGReTTiPnZMeOwM3okVaeOCEe+9kLPvOjfaIuE8oEvHOoH0vYegKslgp1AFIrMB
         AAWw==
X-Forwarded-Encrypted: i=1; AJvYcCUck9rH5GgiwrGm6T27gLNPmy45uGRAbfBVLLV98enVo6JwjrSEiJ7b8RmRolrRVYMuUiziKVdeYRn3@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJKQ9VGA17iJw/Pm2tr4vQHyUChSjf0ywQeEeLYdYnbNm0CxP
	0ii1DOOZvYEo/aJnFyrdSXIZzwKbFn9bVi7U6MwcMrcycExffHCngJTm
X-Gm-Gg: AY/fxX4Mq4Ric+MDDNwNg9FrqAbOij/ULLy/MYb8yIoY829w7dwxG768bsY2D5NcEZb
	n3O8xNqZNusCBz+klKfZD9z8JOu6vBDa0zJ/Lcu5YFbvKd7LoOZ67tXSizYIOHuXfngWdxVzl0e
	aV450+aNCef8D7Bu8vAD3N4Gy4dzpaf2Pc8jmhwcIcTV4pig/9hNNaU7qd2pqAk+FChj1GsyS7w
	Fathk8Ans/g6GWdVWPeYBWYKwHvBhJ17tzk1kNR5LwJH8S8YZFtJ+JG5djN4JCU379qgErzroYJ
	7oYwqMYjcLI/ohFBkvjPPwwYmrHDRo8oJXkQ7ERzjAgsHfDTGGWVlSp67R+PvKVJqNmKFIAcnWN
	BZlWDNpFqQ3rppmpqGSLwh42SsQpPjrTuP4Ks1REaUhlDH0W7LGIm5NWk2ixufWTsN2rlJjHJla
	Dn8fqXJb0IJRmiXnpKzP9gP3dSG1M=
X-Google-Smtp-Source: AGHT+IHohfOhEFk4Mf7LjLQGgnKTKKpnpcw8p3//gTfyYfqXoeDlZ3mCjB5GPCu04MV4ruzVOOQv4A==
X-Received: by 2002:a05:690e:1911:b0:644:46c8:b990 with SMTP id 956f58d0204a3-64716ba14damr11345968d50.32.1768107225992;
        Sat, 10 Jan 2026 20:53:45 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-6470d89d510sm6556709d50.16.2026.01.10.20.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 20:53:45 -0800 (PST)
Message-ID: <ddfa4153-023a-4f48-bff9-6d6a211b6d52@gmail.com>
Date: Sat, 10 Jan 2026 22:53:43 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
To: Aaron Rainbolt <arainbolt@kfocus.org>,
 srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 kernel-team@lists.ubuntu.com
References: <20250517223323.6e13bf58@kf-m2g5>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20250517223323.6e13bf58@kf-m2g5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/17/25 10:33 PM, Aaron Rainbolt wrote:
> We have tested three systems with Arrow Lake CPUs, and all of them
> report incorrect max and base frequencies. Two systems have Ultra 9 275
> HX CPUs, and one has an Ultra 5 225 H. The problem occurs with both the
> Ubuntu 6.11 kernel and the 6.14.6 mainline kernel.
> 
> How these values are misreported appears to depend on the CPU. On the
> Ultra 9 275HX systems when running Ubuntu’s 6.11.0-1015-oem kernel, the
> max reported frequency on a golden core is 5000000; however, the CPU
> spec says it should be 5400000. In contrast, on an Ultra 5 225H system,
> the max reported frequency on a golden core is 6200000;  however, the
> spec says it should be 4900000. 
> 
> This bug is troublesome to end users because many CPU monitoring apps
> will report the CPU is running quite a bit slower or faster than the
> spec. Tools such as cpupower-gui, cpufreq-info, and cpufreq-set all
> show incorrect values because they read cpuinfo_max_freq and
> base_frequency, and write scaling_max_freq values in
> /sys/devices/system/cpu/cpufreq/policy* directories. 
> 
> The following bash script shows the incorrect values read from the
> cpuinfo_max_freq and base_frequency files. It also shows how the actual
> max frequencies attained are as expected. The example values shown come
> from an Ultra 9 275 HX CPU.
> 
>     echo; echo '== BEGIN ==';
>     echo 'Ensure turbo is on';
>     cd /sys/devices/system/cpu;
>     echo '0' |sudo tee intel_pstate/no_turbo > /dev/null;
>     if grep -q '0' intel_pstate/no_turbo; then echo 'Turbo is on'; fi
> 
>     echo; echo 'Find top 2 golden cores';
>     cd /sys/devices/system/cpu/cpufreq/;
>     grep . policy*/cpuinfo_max_freq \
>       | awk -F: '{print $2" "$1}' |sort -rn | head -n2;
>     #> 5000000 policy2/cpuinfo_max_freq
>     #> 5000000 policy3/cpuinfo_max_freq
> 
>     echo; echo 'Confirm misreporting: per spec, this should be 5400000!';
>     grep . policy2/cpuinfo_max_freq; # 500000
> 
>     echo; echo 'Confirm misreporting: per spec, this should be 2700000!'
>     grep . policy2/base_frequency; # 2500000
> 
>     echo; echo '# Run a CPU benchmark now, then press [ Enter ] to see top 3 freqs.';
>     echo 'This will take 6 seconds to complete.';
>     read -r -p '# You should see that the freqs match the CPU specs. ';\ 
>     for i in {0..5}; do
>       grep . policy*/scaling_cur_freq | awk -F: '{print $2" "$1}';
>       sleep 1;
>     done |sort -rn |head -n3 
>     #> 5400000 policy2/scaling_cur_freq
>     #> 5320159 policy2/scaling_cur_freq
>     #> 5241886 policy3/scaling_cur_freq
> 
>     echo; echo '== END   =='; echo;
> 
> The actual results, when running the above script, shows the
> cpuinfo_max_freq and base_frequencies values do not match those
> specified by Intel. With the 6.11.0-1021-oem Ubuntu Kernel, we see the
> following:
> 
> | Turbo? | Core | Freq (spec) | Freq (report) | Freq (actual) |
> | Yes    | P    | 5.4 GHz     | 5.0 GHz       | 5.4 GHz       |
> | No     | P    | 2.7 GHz     | 2.5 GHz       | 2.7 GHz       |
> | Yes    | E    | 4.6 GHz     | 4.6 GHz       | 4.6 GHz       |
> | No     | E    | 2.1 GHz     | 2.1 GHz       | 2.1 GHz       |
> 
> We have verified the cores are operating at their specified frequencies
> by running a demanding CPU benchmark while graphing frequencies with
> KDE System Monitor, on all 3 systems. This tool appeared to graph
> scaling_cur_freq values. Notice E-cores appear to be correctly
> reported. Also, all systems misinterpret values written to
> scaling_max_req with the apparent same error deltas: on the Ultra 9 275
> HX, setting this value to 5000000 results in actual max frequencies of
> 5400000. Setting it to 2500000 results in max 2700000. Setting it to
> 1650000 results in max 2100000.
> 
> The behavior with the 6.14.6 kernel is worse than with 6.11, with all
> values under-reported. Actual frequencies were not tested on 6.14.6:
> 
> | Turbo? | Core | Freq (spec) | Freq (report) |
> | Yes    | P    | 5.4 GHz     | 3.9 GHz       |
> | No     | P    | 2.7 GHz     | 2.0 GHz       |
> | Yes    | E    | 4.6 GHz     | 3.3 GHz       |
> | No     | E    | 2.1 GHz     | 1.5 GHz       |
> 
> Is it possible the math currently used for calculating CPU frequencies
> is no longer correct for Arrow Lake CPUs? This seems similar to the
> issue that was fixed by commit f5c8cf2 (cpufreq: intel_pstate: hybrid:
> Use known scaling factor for P-cores).

It also sounds similar to a situation I reported here [1]. My machine is
a desktop 265K in an ASRock motherboard.

The problem was fixed when I updated the firmware to version 3.11, which
contained microcode 0x11a. That firmware was released in September. The
latest 3.15 from Dec 29 contains microcode 0x11d. You can check by
grepping dmesg for "microcode".
 1.
https://lore.kernel.org/all/53027db5-f750-4b6f-8ac5-a849dff2524b@gmail.com/

