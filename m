Return-Path: <linux-acpi+bounces-15283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D073B0E1F0
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186E77B6F82
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63027A928;
	Tue, 22 Jul 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="dzuAxxHP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79C1E4A9
	for <linux-acpi@vger.kernel.org>; Tue, 22 Jul 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201899; cv=none; b=Ik4R+/9nXGK48rFj4NJHusMqnGyTtFhE5MAOWpmoEGo1ChgCacfpFjGGrZzhRSKaV23w3BYz7uOLIIEzF0q8QY+/elFCuK+zZM2F7ekXhYnTs1+8P6JTddb3ZCdrsgfkfVTXvBrLEfFY+kc5AKO70IAO1APaepTlWR8OJXpVNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201899; c=relaxed/simple;
	bh=8O69cNoFD7AllVOnd5n3rFHoG9oHmmDpmVgaClQAryo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxmoRp2T6ahrb0Hf5rgnowjOvkmt8n9mEY6YezRa6knMbAOnZES04LHIKAl8Xb1yy6OfISzj/uBqtvhz3YGzvhM6stWPPFR9gz6qVoUV22PcqLCMTUIYB+gELOciM4Q6GWDPSQ/t6LMdcxrXFgHnpKRH4M8UNcH07NHr9Eh4QvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=dzuAxxHP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73e810dc4cdso1531895a34.0
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jul 2025 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1753201896; x=1753806696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OKxVxL/LAoBoT2zvn03u4QS0XQT3tH4BCQl9mQgSLO0=;
        b=dzuAxxHPKGNG32wdvuNFFPEEsCrKFAvl6ijzTDMJfF71Bsk+IG9dZr4QM9A7pLpz0T
         5hwQUUanf/P2gc+C4CHWId/U4Ipp7u7hifC/o6FTFyf2e1MZehowxAb78g7rAGj4360f
         ll/+oxuLTf2SqfqjZZ2xPdkGU7DDLTuQgzHuqlwKn9Sy90qZxNjtg1DHFoplgcbNwtop
         BP+sYEszlmEUW9bIuX2g1m2UDThJGa1IJDNk9UJX1Mm7ubTHb/WvyE+FXeG3bjAaJApF
         r09Avfai9W+ZSaJtaxO5dxt4qihhes0w4WdCsNVERNVdkY0js+Ln+cD1GrJn3WVUHB0/
         TtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201896; x=1753806696;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKxVxL/LAoBoT2zvn03u4QS0XQT3tH4BCQl9mQgSLO0=;
        b=DA8LB2RzN7NYAfW2KcHvsaDgsOZihjSRoBWMCMIwB0VtvH11axceu9KkDy58+QimWI
         6BdriAFJewNv9GMqOehEGdi8yycfXDff5SQLIh/2o/p1oTQI0eWNBrajyAdfnkVzGteS
         SAVcH1Swbe3rVITtW9ygaqgSVmm7ofIjM4sZW9VXQwFM4iZFcsuZt2+ImeiZ/90nTHoZ
         B1G9rY8cekg89MJ9JkpLRvAeMIDJ3hCyz3bOg1WgYG3avN6ACvyJf6wQOjV5gWhPg4iR
         yJ/HbOLsGmowiY412Mdj0itdgEyyFxo2znu7EsiaH8jey0haRhJRjukRdDF5Wi83RT38
         nO4g==
X-Forwarded-Encrypted: i=1; AJvYcCV6wBEBcdKyefIQi7/y9EuxvFHtqqAmzSc+n6Qf/2QbSnsW+M0eMw0WvW+CJZIqxpVW6vrQO5pY5Fw4@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9e2lS30Efo6ue6GmxhSuP9SLQvBqqmdZMBZbJ6VV8D+9uvl/
	4DfIZziGV/ryr8u4mxiXiurQLlZFwyYK2WNf3YmODzrveKlVHM5FktXqFCRWiyJIg+s=
X-Gm-Gg: ASbGncv6TmC9aMJr/C8KkZAn4T1Q4TguJ/rXuezcJDsbtZZ0C9zJ6eY60yNmq4v9LaQ
	D+UPkR3sUwsiwlQkz629rDQaAiGmWwGLAyO3brEMayfCFAE9/Xnfqgpy+nvcE5VJKxtGHH0wNpr
	3faFc9oIDLsGCROr01VOWz9KMZxzWH4pqydvQyAf6susgGuu1qf46YEfOJXtdIr5kIu29kmz3bv
	d/zycv0/lDmDsFZqUM5cYSWlWxX45h8RYJ1OnOcexH11JcCrEFnIM0iOnC8nVvEbump+Yp1Brrz
	CBq2cPss21nTb5GRak1LrHWJVeuL/07HylnE+AjNe/qL533KMRtw5NwdOyBzhkzUVZeOPfYN0PC
	muswlAUUkC4+2Cnseqeif
X-Google-Smtp-Source: AGHT+IEJXPfNhEgj6Ylfn91LH0XYYsRLvRZhaGuYQ2/jHp5T9SVcaV36Pthzwfk9FBWVTgeM/c78VA==
X-Received: by 2002:a05:6830:d07:b0:72b:84a7:47e0 with SMTP id 46e09a7af769-73e649c8a5dmr18665143a34.1.1753201896532;
        Tue, 22 Jul 2025 09:31:36 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:bf84:45ad:48e4:ec32:d2d1:cd6e])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c786c5dsm2627468173.15.2025.07.22.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:31:36 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:31:33 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 kernel-team@lists.ubuntu.com
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20250722113133.3a048c7a@kf-m2g5>
In-Reply-To: <20250517223323.6e13bf58@kf-m2g5>
References: <20250517223323.6e13bf58@kf-m2g5>
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

On Sat, 17 May 2025 22:33:23 -0500
Aaron Rainbolt <arainbolt@kfocus.org> wrote:

> We have tested three systems with Arrow Lake CPUs, and all of them
> report incorrect max and base frequencies. Two systems have Ultra 9
> 275 HX CPUs, and one has an Ultra 5 225 H. The problem occurs with
> both the Ubuntu 6.11 kernel and the 6.14.6 mainline kernel.
>=20
> How these values are misreported appears to depend on the CPU. On the
> Ultra 9 275HX systems when running Ubuntu=E2=80=99s 6.11.0-1015-oem kerne=
l,
> the max reported frequency on a golden core is 5000000; however, the
> CPU spec says it should be 5400000. In contrast, on an Ultra 5 225H
> system, the max reported frequency on a golden core is 6200000;
> however, the spec says it should be 4900000.=20
>=20
> This bug is troublesome to end users because many CPU monitoring apps
> will report the CPU is running quite a bit slower or faster than the
> spec. Tools such as cpupower-gui, cpufreq-info, and cpufreq-set all
> show incorrect values because they read cpuinfo_max_freq and
> base_frequency, and write scaling_max_freq values in
> /sys/devices/system/cpu/cpufreq/policy* directories.=20
>=20
> The following bash script shows the incorrect values read from the
> cpuinfo_max_freq and base_frequency files. It also shows how the
> actual max frequencies attained are as expected. The example values
> shown come from an Ultra 9 275 HX CPU.
>=20
>     echo; echo '=3D=3D BEGIN =3D=3D';
>     echo 'Ensure turbo is on';
>     cd /sys/devices/system/cpu;
>     echo '0' |sudo tee intel_pstate/no_turbo > /dev/null;
>     if grep -q '0' intel_pstate/no_turbo; then echo 'Turbo is on'; fi
>=20
>     echo; echo 'Find top 2 golden cores';
>     cd /sys/devices/system/cpu/cpufreq/;
>     grep . policy*/cpuinfo_max_freq \
>       | awk -F: '{print $2" "$1}' |sort -rn | head -n2;
>     #> 5000000 policy2/cpuinfo_max_freq
>     #> 5000000 policy3/cpuinfo_max_freq =20
>=20
>     echo; echo 'Confirm misreporting: per spec, this should be
> 5400000!'; grep . policy2/cpuinfo_max_freq; # 500000
>=20
>     echo; echo 'Confirm misreporting: per spec, this should be
> 2700000!' grep . policy2/base_frequency; # 2500000
>=20
>     echo; echo '# Run a CPU benchmark now, then press [ Enter ] to
> see top 3 freqs.'; echo 'This will take 6 seconds to complete.';
>     read -r -p '# You should see that the freqs match the CPU specs.
> ';\ for i in {0..5}; do
>       grep . policy*/scaling_cur_freq | awk -F: '{print $2" "$1}';
>       sleep 1;
>     done |sort -rn |head -n3=20
>     #> 5400000 policy2/scaling_cur_freq
>     #> 5320159 policy2/scaling_cur_freq
>     #> 5241886 policy3/scaling_cur_freq =20
>=20
>     echo; echo '=3D=3D END   =3D=3D'; echo;
>=20
> The actual results, when running the above script, shows the
> cpuinfo_max_freq and base_frequencies values do not match those
> specified by Intel. With the 6.11.0-1021-oem Ubuntu Kernel, we see the
> following:
>=20
> | Turbo? | Core | Freq (spec) | Freq (report) | Freq (actual) |
> | Yes    | P    | 5.4 GHz     | 5.0 GHz       | 5.4 GHz       |
> | No     | P    | 2.7 GHz     | 2.5 GHz       | 2.7 GHz       |
> | Yes    | E    | 4.6 GHz     | 4.6 GHz       | 4.6 GHz       |
> | No     | E    | 2.1 GHz     | 2.1 GHz       | 2.1 GHz       |
>=20
> We have verified the cores are operating at their specified
> frequencies by running a demanding CPU benchmark while graphing
> frequencies with KDE System Monitor, on all 3 systems. This tool
> appeared to graph scaling_cur_freq values. Notice E-cores appear to
> be correctly reported. Also, all systems misinterpret values written
> to scaling_max_req with the apparent same error deltas: on the Ultra
> 9 275 HX, setting this value to 5000000 results in actual max
> frequencies of 5400000. Setting it to 2500000 results in max 2700000.
> Setting it to 1650000 results in max 2100000.
>=20
> The behavior with the 6.14.6 kernel is worse than with 6.11, with all
> values under-reported. Actual frequencies were not tested on 6.14.6:
>=20
> | Turbo? | Core | Freq (spec) | Freq (report) |
> | Yes    | P    | 5.4 GHz     | 3.9 GHz       |
> | No     | P    | 2.7 GHz     | 2.0 GHz       |
> | Yes    | E    | 4.6 GHz     | 3.3 GHz       |
> | No     | E    | 2.1 GHz     | 1.5 GHz       |
>=20
> Is it possible the math currently used for calculating CPU frequencies
> is no longer correct for Arrow Lake CPUs? This seems similar to the
> issue that was fixed by commit f5c8cf2 (cpufreq: intel_pstate: hybrid:
> Use known scaling factor for P-cores).

Following up on this, is there any update or possible fix we could
test?

