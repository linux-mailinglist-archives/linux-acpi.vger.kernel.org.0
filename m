Return-Path: <linux-acpi+bounces-18603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D2C3D461
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 20:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1EC14E4577
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 19:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78D346787;
	Thu,  6 Nov 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="0GI3xgSD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F7340DA6
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458411; cv=none; b=smYZhJZXKXuLGN+3rUO9QQLUK/aaJmJ/RpbmoIVvRnnmPtu1zy1thcEO4BzV2D+Gre39KQNGNPw9QqRf+vzjS2ev79sX8DROV8YSVCQocn9+gaUkMf/XXpJnlZC34sexm9WIuzVUepgIG36ifRsSvyDsFZ39hJKzzQqRUA2L2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458411; c=relaxed/simple;
	bh=pLcdBJdtxI020Yns4EoqATEpJwIN1bvrdTtAjdOjufo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMhJStjQjoGv5hsKdiW0LcngJyAyJszx1gvzyY8/QK68L7/I06TepZtjacTeA7U0j9ygWqQ6eqrOmO6qxvCKNXila1l4dpZ6jCb2zPRGhupvYDxtxAPBm8eB+cNLK88Imeb5UKWfCjVEgCLKgsU9xAR9lJBcH9fxpgnaZo+svcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=0GI3xgSD; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-934f0e9d4afso623241.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 11:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1762458408; x=1763063208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvo45XTSArxSuHNskpjA6d1ja2PsdeMrkLdrewsq6J8=;
        b=0GI3xgSDoZO5AFiCMj+so0HdD/yEIyHLjChgE3HoFoR73GxPyp3WA/PaISdbH8fknZ
         gYOGsN6BnNOOspaztdTE/qj3wMfAoZe2XFv/f6qgaJ2ZhSjWAqbfFabHa1pjoYJ/WKUX
         wtwxbOt6BEJenaaLrqJht+8wGIT/zZC0+1C60qerneIis0yRxT0J/bbYrpPZD86ka0cQ
         yUm/J+l11/29prY4A2lcnYOpTwZ81CvVcx6UN+n9Z3U2eobe+PhoEVh3poqKxgh/Ctnv
         eleeGSWfbiNBTi8BNQKG6fKuqvVXEeSbS7/wWFOGOrI5XhG/gSlTyWx1FsAUMKVxxcT5
         uzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762458408; x=1763063208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zvo45XTSArxSuHNskpjA6d1ja2PsdeMrkLdrewsq6J8=;
        b=BFfRFtd+u25W3LT+wnEtRC+dOhrXKzMUdn+L6MRTlewJzpX11XcUVyh1PWSjhBPz+r
         ADj8MDbygPhQvUHRuWnESwy4wqk+n7xWbmM+Xw4MdqvpAqKFzNfkP91+MrwQ5aSdmFqN
         ffNOY7KB7ub5rJxlxlhnm3u/tRefVvjLHfZxb4kPbVwn+hl6FQuxlSlhowF1hsT3MJRC
         7WFfVNKkHkJjZemM+GPi1ZkzijFaWDXM9QjpSyFaJn403k0qGkY7XleF/+beNicAz1GK
         lUnCaElvu7jLelslJ/Sa+pRlt53HQP2QDWjm0uNKG9dtEWKX1mV7s+rz0BJGrd/ctvuy
         phRA==
X-Forwarded-Encrypted: i=1; AJvYcCUTyT9f+vXC3yk6UdVd3LQxXXteg5TyDVfSGyzkcOXlsXuLRY9+7wJdKWBSTGJYVV8zMcRoKcl+bcno@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LBEsVuhRtBIIvHYl97wZaY19PIr6NcbFxRS+xbWuVCxhcGl8
	DEgGiPbEPPlc+cX111em5R5bvsIzJfbj2q6Jks1ie1Zbnh3KQbz0ntDPJMxVjdoPiFYQG3IjhD9
	HRUhDPd85wQ0Tjz3IVWxYN4sfGss4Ycfh88hrWMTTwQ==
X-Gm-Gg: ASbGncvozCMrXXmaD1Io0+WeFa5nZ/Q7g9hSQpucDoqcAnHHw5aVBGqI+NENLcYdlAx
	tgcLRv8lFG+g8neB0FWBnEmtHFtSGnSZOOJHUiPRz0kyINK4vCDdXQfaFKPNU0nOypEG4VKM/qu
	UJsFUH8i61f79ZbYYkcyTTsGBgHMNNwGdeM1EKhOdForF1YWdyNIWCDOF6RYI/8Kobv/S3O+YG6
	pEpxe4vAxxRwWtNHjcfaTtp1nSCSwuuHHCSuLor6W7gZ4wYGI6tbw8ni0RhJNUEie6+Za8jg1Pd
	l3HI614hByCHmsf1AUs=
X-Google-Smtp-Source: AGHT+IGLtJekpkk3yXHMbJWNgjahkQWvswgacd9ut97nQ463dZZHMYcqw3XIkR+lZuNAlK/z5Xwvqh/uWvzfN1qQpYI=
X-Received: by 2002:a05:6102:c05:b0:5db:e297:2c6c with SMTP id
 ada2fe7eead31-5ddb22db849mr283178137.42.1762458408082; Thu, 06 Nov 2025
 11:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517223323.6e13bf58@kf-m2g5> <3761c1edef2c431a65f5fba2c5c64a2a882060cb.camel@linux.intel.com>
In-Reply-To: <3761c1edef2c431a65f5fba2c5c64a2a882060cb.camel@linux.intel.com>
From: Aaron Rainbolt <arainbolt@kfocus.org>
Date: Thu, 6 Nov 2025 13:46:11 -0600
X-Gm-Features: AWmQ_blpaCJmSSqoW4zTZG1eaIVp23NsRHAqyblE0U9xhoM6kGXt8I-ruymqG2Q
Message-ID: <CAHuw_Q4FP24p=Hjr0R=50DFEfnmBeHV-pXdp7jk-Thw+EB8p0g@mail.gmail.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, kernel-team@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 7:48=E2=80=AFAM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
>
> On Sat, 2025-05-17 at 22:33 -0500, Aaron Rainbolt wrote:
> > We have tested three systems with Arrow Lake CPUs, and all of them
> > report incorrect max and base frequencies. Two systems have Ultra 9
> > 275
> > HX CPUs, and one has an Ultra 5 225 H. The problem occurs with both
> > the
> > Ubuntu 6.11 kernel and the 6.14.6 mainline kernel.
> >
> > How these values are misreported appears to depend on the CPU. On the
> > Ultra 9 275HX systems when running Ubuntu=E2=80=99s 6.11.0-1015-oem ker=
nel,
> > the
> > max reported frequency on a golden core is 5000000; however, the CPU
> > spec says it should be 5400000. In contrast, on an Ultra 5 225H
> > system,
> > the max reported frequency on a golden core is 6200000;  however, the
> > spec says it should be 4900000.
> >
>
> I think this is similar to
> https://lkml.indiana.edu/2504.3/04971.html
>
> The issue is the BIOS didn't program frequencies correctly in ACPI
> CPPC. So frequency limits will be wrong.
>
> You can dump the following values and also the details about the system
> under test (OEM, model etc).
>
> grep -r . /sys/devices/system/cpu/cpu*/acpi_cppc/*
>
>
> Thanks,
> Srinivas

I am so sorry to have missed this for literally months. Somehow this
never ended up in my inbox,
Gmail stuffed it in some other folder I don't ever look at, and my
normal email client (Claws)
refuses to show it to me. Hopefully sending this will make it show up
where it should...

I'll try to get some model information and logs soon. Thanks for your
patience, and sorry about the
probably ridiculous-looking followup email from July.

> > This bug is troublesome to end users because many CPU monitoring apps
> > will report the CPU is running quite a bit slower or faster than the
> > spec. Tools such as cpupower-gui, cpufreq-info, and cpufreq-set all
> > show incorrect values because they read cpuinfo_max_freq and
> > base_frequency, and write scaling_max_freq values in
> > /sys/devices/system/cpu/cpufreq/policy* directories.
> >
> > The following bash script shows the incorrect values read from the
> > cpuinfo_max_freq and base_frequency files. It also shows how the
> > actual
> > max frequencies attained are as expected. The example values shown
> > come
> > from an Ultra 9 275 HX CPU.
> >
> >     echo; echo '=3D=3D BEGIN =3D=3D';
> >     echo 'Ensure turbo is on';
> >     cd /sys/devices/system/cpu;
> >     echo '0' |sudo tee intel_pstate/no_turbo > /dev/null;
> >     if grep -q '0' intel_pstate/no_turbo; then echo 'Turbo is on'; fi
> >
> >     echo; echo 'Find top 2 golden cores';
> >     cd /sys/devices/system/cpu/cpufreq/;
> >     grep . policy*/cpuinfo_max_freq \
> >       | awk -F: '{print $2" "$1}' |sort -rn | head -n2;
> >     #> 5000000 policy2/cpuinfo_max_freq
> >     #> 5000000 policy3/cpuinfo_max_freq
> >
> >     echo; echo 'Confirm misreporting: per spec, this should be
> > 5400000!';
> >     grep . policy2/cpuinfo_max_freq; # 500000
> >
> >     echo; echo 'Confirm misreporting: per spec, this should be
> > 2700000!'
> >     grep . policy2/base_frequency; # 2500000
> >
> >     echo; echo '# Run a CPU benchmark now, then press [ Enter ] to
> > see top 3 freqs.';
> >     echo 'This will take 6 seconds to complete.';
> >     read -r -p '# You should see that the freqs match the CPU specs.
> > ';\
> >     for i in {0..5}; do
> >       grep . policy*/scaling_cur_freq | awk -F: '{print $2" "$1}';
> >       sleep 1;
> >     done |sort -rn |head -n3
> >     #> 5400000 policy2/scaling_cur_freq
> >     #> 5320159 policy2/scaling_cur_freq
> >     #> 5241886 policy3/scaling_cur_freq
> >
> >     echo; echo '=3D=3D END   =3D=3D'; echo;
> >
> > The actual results, when running the above script, shows the
> > cpuinfo_max_freq and base_frequencies values do not match those
> > specified by Intel. With the 6.11.0-1021-oem Ubuntu Kernel, we see
> > the
> > following:
> >
> > > Turbo? | Core | Freq (spec) | Freq (report) | Freq (actual) |
> > > Yes    | P    | 5.4 GHz     | 5.0 GHz       | 5.4 GHz       |
> > > No     | P    | 2.7 GHz     | 2.5 GHz       | 2.7 GHz       |
> > > Yes    | E    | 4.6 GHz     | 4.6 GHz       | 4.6 GHz       |
> > > No     | E    | 2.1 GHz     | 2.1 GHz       | 2.1 GHz       |
> >
> > We have verified the cores are operating at their specified
> > frequencies
> > by running a demanding CPU benchmark while graphing frequencies with
> > KDE System Monitor, on all 3 systems. This tool appeared to graph
> > scaling_cur_freq values. Notice E-cores appear to be correctly
> > reported. Also, all systems misinterpret values written to
> > scaling_max_req with the apparent same error deltas: on the Ultra 9
> > 275
> > HX, setting this value to 5000000 results in actual max frequencies
> > of
> > 5400000. Setting it to 2500000 results in max 2700000. Setting it to
> > 1650000 results in max 2100000.
> >
> > The behavior with the 6.14.6 kernel is worse than with 6.11, with all
> > values under-reported. Actual frequencies were not tested on 6.14.6:
> >
> > > Turbo? | Core | Freq (spec) | Freq (report) |
> > > Yes    | P    | 5.4 GHz     | 3.9 GHz       |
> > > No     | P    | 2.7 GHz     | 2.0 GHz       |
> > > Yes    | E    | 4.6 GHz     | 3.3 GHz       |
> > > No     | E    | 2.1 GHz     | 1.5 GHz       |
> >
> > Is it possible the math currently used for calculating CPU
> > frequencies
> > is no longer correct for Arrow Lake CPUs? This seems similar to the
> > issue that was fixed by commit f5c8cf2 (cpufreq: intel_pstate:
> > hybrid:
> > Use known scaling factor for P-cores).
>

