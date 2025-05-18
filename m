Return-Path: <linux-acpi+bounces-13774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950D5ABAD9B
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 05:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246EF163500
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 03:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230B12B17C;
	Sun, 18 May 2025 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="2s3Sn/F8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9A78F4E
	for <linux-acpi@vger.kernel.org>; Sun, 18 May 2025 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747539213; cv=none; b=R0BZUr5+Bt8D2xskMlSjSJ7GqN1IDumICMGUglzbYQ7MsosNYV9msvURPH/pblkywa4CkvUVAabzXzOWGJzwaSnJ1Yjsn59RYGwIb3RfNtiyVWMOM8FYmN7cGiJCIkkqHxKOCh3hzkC6M0SQ8+RnF9jrhPIedyVYQ5aiaK/+Wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747539213; c=relaxed/simple;
	bh=Qcok2HA9vTfwFdHCTVEK07ccJdSZwKZ7gEg3B1mT0SE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XaYItEjFPbIP2f38u0jkhDycDfECKSBEcDmmJzskfEv1BRrjIv4DdDhnosQC7uetT8p0ixUug4QWKpWv+wzfVfN54SH2pc5CTTt1y3KDr3XB2jvmvLbD2guniVV5Khshu+TS80xdl2+koLP4jflbha5qb/0sEEplN3BJGMCSc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=2s3Sn/F8; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3da73e9cf17so29771155ab.2
        for <linux-acpi@vger.kernel.org>; Sat, 17 May 2025 20:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1747539210; x=1748144010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q66axFNwX/OOJa3rSvoRH2bP/IkJhfyrHcNnQZV7mqs=;
        b=2s3Sn/F8NxYcq93vfit1NVJAowEuUlTj4z3gGciiHb0ud/sOWFHJBDa4DudupVhC9f
         A/p0Uh+F9Gw3vurB8d/OrA5P3HTJWmKQIhA+AaAlQzjJpe04DpoupxJ+WfSbYkxPadI5
         RbM3175mlHzQHtQWHOkQ00Y+wtWLhAddgYW/XqXU2+rjysGNR/VYiwiKhQZ7AGikoqCf
         lSF5n9tp4KlTpAWa7DdGg07kbIsNdnBCx8QkkPtDKy0QTjnQCoIL7S/HY1aAJ9BNtTIC
         btuAR74UdwChGQp0RQz7NTVPAgyODYMIWeuenM9ZxIZU4Xa19BApH0sOgilHyrZQh4vL
         Wj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747539210; x=1748144010;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q66axFNwX/OOJa3rSvoRH2bP/IkJhfyrHcNnQZV7mqs=;
        b=aow3/mfxeU0UdGveRS67JoHDaKigGAe4azc5J2hixhPeg/2U+XwNvXxAiTnXXLef0T
         HgkP2CjUH3YgQ71ZqBK4l4mCov6MsqoMlhvXRjK6GJUI+0/Y0kIux4tt+Rk/5Y/ThOmR
         /zCWU/RY68YC0aVM6zkut1eGu4xLCsG4V7Ai4naRAr9gTJeWGWOLveBveoiwVoVt7Am6
         7llEKFBgYTf0HRBNmYlFiVjWihRG2QSAqrnhlvf3AoA2lnkuxPqof99cfb8cxDVZREEX
         RIVvYXDU+xQW2N2mHyOfAZKNk8x+Mlk2nTE5EN0fb/ktoRuBgz2F31ESLfM7zqtFn1X3
         Isew==
X-Forwarded-Encrypted: i=1; AJvYcCXu7WvOu/l5mq02BknGoDlDuwofjQwrsqOdZzD12cDAkWYsaY5qf2KDJsxGRxgVF9e4UkfvvKqNdKqh@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwMuJqccZkSBprEI4g6+LI5NKkuSzFaxytstUcByThrrfLrgF
	0huuKvCKDrbc/LHiI0cIIbXQFJ2aILhf/KoQ+Ryu6pr6+fvbwwDkZUDmRKSysFWbwHGeevAZZ+9
	sY4ds
X-Gm-Gg: ASbGnct2mZT+PrBHFdetjDKYhHQgEVUXcbQrX4df04YV1QH3dU/CN8uWTS7gw8wt/XZ
	mXro6S9PXRQ0CeeKIWl+hUUyzgcgl4iXfFT6t5Sl5HMkd+XL6sP18YBJsBxnLf6gTRe7rzvjPKl
	1XE5e5u0s9ycFk7pbeuRpaKtqdaC9lzjMV78VKo4fhfMTrcZIHSB0gwqKOh6duIOOV5O2EHUrEy
	GyCk7K7Er2ewuD+KgCyzzLjEkLU6YkKQyqO/d6apYieaUHtfiVFhJxl6M+lVcU/dDBOmM+sqUW/
	+It1HqE2svAtzsn8bFDxaxe//36zh1R4uXS/l8RJgg0KeRwj6A==
X-Google-Smtp-Source: AGHT+IGuZEkCOiHSAV46kJ8+5tKLpqMP5vNUcLX7dfiS8jc7cyBPiTeK+LOScScxytNuyNOhII3pQg==
X-Received: by 2002:a05:6e02:1745:b0:3db:7b4c:309b with SMTP id e9e14a558f8ab-3db8429768amr109263565ab.2.1747539210347;
        Sat, 17 May 2025 20:33:30 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:bfd8:c847:9e04:66f4:d76b:5edd])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db8443a3b8sm13071295ab.48.2025.05.17.20.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 20:33:29 -0700 (PDT)
Date: Sat, 17 May 2025 22:33:23 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 kernel-team@lists.ubuntu.com
Subject: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20250517223323.6e13bf58@kf-m2g5>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

We have tested three systems with Arrow Lake CPUs, and all of them
report incorrect max and base frequencies. Two systems have Ultra 9 275
HX CPUs, and one has an Ultra 5 225 H. The problem occurs with both the
Ubuntu 6.11 kernel and the 6.14.6 mainline kernel.

How these values are misreported appears to depend on the CPU. On the
Ultra 9 275HX systems when running Ubuntu=E2=80=99s 6.11.0-1015-oem kernel,=
 the
max reported frequency on a golden core is 5000000; however, the CPU
spec says it should be 5400000. In contrast, on an Ultra 5 225H system,
the max reported frequency on a golden core is 6200000;  however, the
spec says it should be 4900000.=20

This bug is troublesome to end users because many CPU monitoring apps
will report the CPU is running quite a bit slower or faster than the
spec. Tools such as cpupower-gui, cpufreq-info, and cpufreq-set all
show incorrect values because they read cpuinfo_max_freq and
base_frequency, and write scaling_max_freq values in
/sys/devices/system/cpu/cpufreq/policy* directories.=20

The following bash script shows the incorrect values read from the
cpuinfo_max_freq and base_frequency files. It also shows how the actual
max frequencies attained are as expected. The example values shown come
from an Ultra 9 275 HX CPU.

    echo; echo '=3D=3D BEGIN =3D=3D';
    echo 'Ensure turbo is on';
    cd /sys/devices/system/cpu;
    echo '0' |sudo tee intel_pstate/no_turbo > /dev/null;
    if grep -q '0' intel_pstate/no_turbo; then echo 'Turbo is on'; fi

    echo; echo 'Find top 2 golden cores';
    cd /sys/devices/system/cpu/cpufreq/;
    grep . policy*/cpuinfo_max_freq \
      | awk -F: '{print $2" "$1}' |sort -rn | head -n2;
    #> 5000000 policy2/cpuinfo_max_freq
    #> 5000000 policy3/cpuinfo_max_freq

    echo; echo 'Confirm misreporting: per spec, this should be 5400000!';
    grep . policy2/cpuinfo_max_freq; # 500000

    echo; echo 'Confirm misreporting: per spec, this should be 2700000!'
    grep . policy2/base_frequency; # 2500000

    echo; echo '# Run a CPU benchmark now, then press [ Enter ] to see top =
3 freqs.';
    echo 'This will take 6 seconds to complete.';
    read -r -p '# You should see that the freqs match the CPU specs. ';\=20
    for i in {0..5}; do
      grep . policy*/scaling_cur_freq | awk -F: '{print $2" "$1}';
      sleep 1;
    done |sort -rn |head -n3=20
    #> 5400000 policy2/scaling_cur_freq
    #> 5320159 policy2/scaling_cur_freq
    #> 5241886 policy3/scaling_cur_freq

    echo; echo '=3D=3D END   =3D=3D'; echo;

The actual results, when running the above script, shows the
cpuinfo_max_freq and base_frequencies values do not match those
specified by Intel. With the 6.11.0-1021-oem Ubuntu Kernel, we see the
following:

| Turbo? | Core | Freq (spec) | Freq (report) | Freq (actual) |
| Yes    | P    | 5.4 GHz     | 5.0 GHz       | 5.4 GHz       |
| No     | P    | 2.7 GHz     | 2.5 GHz       | 2.7 GHz       |
| Yes    | E    | 4.6 GHz     | 4.6 GHz       | 4.6 GHz       |
| No     | E    | 2.1 GHz     | 2.1 GHz       | 2.1 GHz       |

We have verified the cores are operating at their specified frequencies
by running a demanding CPU benchmark while graphing frequencies with
KDE System Monitor, on all 3 systems. This tool appeared to graph
scaling_cur_freq values. Notice E-cores appear to be correctly
reported. Also, all systems misinterpret values written to
scaling_max_req with the apparent same error deltas: on the Ultra 9 275
HX, setting this value to 5000000 results in actual max frequencies of
5400000. Setting it to 2500000 results in max 2700000. Setting it to
1650000 results in max 2100000.

The behavior with the 6.14.6 kernel is worse than with 6.11, with all
values under-reported. Actual frequencies were not tested on 6.14.6:

| Turbo? | Core | Freq (spec) | Freq (report) |
| Yes    | P    | 5.4 GHz     | 3.9 GHz       |
| No     | P    | 2.7 GHz     | 2.0 GHz       |
| Yes    | E    | 4.6 GHz     | 3.3 GHz       |
| No     | E    | 2.1 GHz     | 1.5 GHz       |

Is it possible the math currently used for calculating CPU frequencies
is no longer correct for Arrow Lake CPUs? This seems similar to the
issue that was fixed by commit f5c8cf2 (cpufreq: intel_pstate: hybrid:
Use known scaling factor for P-cores).

