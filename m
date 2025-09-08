Return-Path: <linux-acpi+bounces-16500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEDB49777
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E7E2044AD
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CFC313292;
	Mon,  8 Sep 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ55R3nr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315E3126DB;
	Mon,  8 Sep 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353454; cv=none; b=lvklgHmzEKdbiDy6+Vo3j+0wQuDV4bpZ21BBqmpQeQliF1uVO6UAVjEp3PPE02cgn/xCYMuEr2V4HGV7wP6Uir74M5gkQdmPPvW88HqAP260NAG1lBu9oQGbyaGNPjWosUIyJjV+8GkCFyPuL/fczMIGsYrRpbiP4kqvr/1WGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353454; c=relaxed/simple;
	bh=pxv4SKGaeo+/iwpYsHET1lGXi6vy1Me0WnNKi9ZjTC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fok9FDCzNApE1oxbP8P5dWdOo1nrPyek8+69u2uUWk8yrlRzbqFhxkGMvR61HE6IbDWOnW/4+A3kyf1wEu+iurd7XfKo5lqvSP7N2q0u6c1zCxNm51TVVF1rd48h01HUOl0ovL5I67zhbiz/pH5I+1ekjG9o6J0kQRNqd+VjS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ55R3nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA3DC4CEF7;
	Mon,  8 Sep 2025 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757353454;
	bh=pxv4SKGaeo+/iwpYsHET1lGXi6vy1Me0WnNKi9ZjTC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uQ55R3nryISj4fR5HBA0VoKRZaL0v3af3ouPwi2RYm+lkfp+cjWrR+LX97PQ39TS1
	 clH9A7/msCwa+hxqIXvZap62ixLxWNUKGlyOeLuJV8znNAyQIIIlIRl7QdF9UFedNx
	 /zzbC62VRoizSlgV9RXiMFblpCIyIdzz5InicZSgkGQa5gJNSmQ9JPTCCTrMF1450E
	 WqwqOE5QYrbszoHVL/c8r7aVLjzlTVX8pWSgdStRA2xntbvfP1x7rQyr+rD6fhFc0o
	 J+VT7dY5asCWkyo9eFP04FfqRkHLvlAbHP3e4Euy0HrUB7bOv1NGBWr90PGQZVedzN
	 8WpYZnTJv15ew==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74382041c9eso3397308a34.3;
        Mon, 08 Sep 2025 10:44:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTzMXfwZV7W7QjX49RgBPyEtUHWQ/Afl1TFtsmS0SDRrT8is+2bKwk7+uYA0Qm8Km4ZQgRsGK8bqgr@vger.kernel.org, AJvYcCVVdZtXbbZc+vTyINgy9vVso/OMrjsbW3uJ/TDwTWXbj+nedaHYJgmCjZeF8e/lFUTpzO1brucDMKUkxA==@vger.kernel.org, AJvYcCWlZkHAbw/3w6ZTt6FpgHqRKGAZ3Xq4khlQ0JTLCt5zZMV3G+23JZN92259/DQ1s4DavyN07osFe2SIXxu9@vger.kernel.org, AJvYcCXGmbVEpE2WHozBPjHvmZS38qKWa26g9ZDKmzSxzMkB/n+hVpSoFcQ/cfGfKfU9bPqHbdrc16z95VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwINSDgX5oF4M8Bk7prIfTTlmthf/wg1rmEgZBA/ciVMAwHs5/R
	T4QPcLIRwRDXMmtdDEe2Pd6RBCxXIggtO9AnCHg4D6VzaKr9d3XI/4PMvgQKUoWlJz1Su6g5x0D
	0SFqS3H79Y3KZO8wY3q4qwRqkPRYkJJU=
X-Google-Smtp-Source: AGHT+IEmLNooDlmw6mUZRYEbyTwg6KsbFI0N3/Ra3KC+hBAS5x57Hk+ruqmJHv0ou2jqI/XILrzNZEQVMGT+C7Z3Oeg=
X-Received: by 2002:a05:6808:198f:b0:439:b82f:ce with SMTP id
 5614622812f47-43b29b4d9d1mr3597972b6e.31.1757353453065; Mon, 08 Sep 2025
 10:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905132413.1376220-1-zhangzihuan@kylinos.cn>
 <20250905132413.1376220-3-zhangzihuan@kylinos.cn> <CAJZ5v0iTdgM5BBi2ysiJxfA2c=MQ0fjLsEvVct9stxomvEe=4Q@mail.gmail.com>
 <6683fb5a-64f4-433e-a22b-153b01dfa572@kylinos.cn>
In-Reply-To: <6683fb5a-64f4-433e-a22b-153b01dfa572@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Sep 2025 19:44:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h9pYXi4Op4zAA+Q7QZz5gkJg+83eKUCqM-YKh76CVLKg@mail.gmail.com>
X-Gm-Features: Ac12FXxUqqlT9sudI62ao99U1pS-dgaUtp-l-yYYj3dQjoUJWeYTt-vc3mF_8T8
Message-ID: <CAJZ5v0h9pYXi4Op4zAA+Q7QZz5gkJg+83eKUCqM-YKh76CVLKg@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] ACPI: processor: thermal: Use scope-based cleanup helper
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Thierry Reding <thierry.reding@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Ben Horgan <ben.horgan@arm.com>, 
	zhenglifeng <zhenglifeng1@huawei.com>, Zhang Rui <rui.zhang@intel.com>, 
	Len Brown <lenb@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Beata Michalska <beata.michalska@arm.com>, 
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>, Sumit Gupta <sumitg@nvidia.com>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:16=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
>
> =E5=9C=A8 2025/9/6 04:17, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Fri, Sep 5, 2025 at 3:24=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylino=
s.cn> wrote:
> >> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> >> annotation for policy references. This reduces the risk of reference
> >> counting mistakes and aligns the code with the latest kernel style.
> >>
> >> No functional change intended.
> >>
> >> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> >> ---
> >>   drivers/acpi/processor_thermal.c | 52 +++++++++++++++++-------------=
--
> >>   1 file changed, 27 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor=
_thermal.c
> >> index 1219adb11ab9..460713d1414a 100644
> >> --- a/drivers/acpi/processor_thermal.c
> >> +++ b/drivers/acpi/processor_thermal.c
> >> @@ -62,19 +62,14 @@ static int phys_package_first_cpu(int cpu)
> >>          return 0;
> >>   }
> >>
> >> -static int cpu_has_cpufreq(unsigned int cpu)
> >> +static bool cpu_has_cpufreq(unsigned int cpu)
> >>   {
> >> -       struct cpufreq_policy *policy;
> >> -
> >>          if (!acpi_processor_cpufreq_init)
> >>                  return 0;
> >>
> >> -       policy =3D cpufreq_cpu_get(cpu);
> >> -       if (policy) {
> >> -               cpufreq_cpu_put(policy);
> >> -               return 1;
> >> -       }
> >> -       return 0;
> >> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D c=
pufreq_cpu_get(cpu);
> >> +
> >> +       return policy !=3D NULL;
> >>   }
> >>
> >>   static int cpufreq_get_max_state(unsigned int cpu)
> > The changes above are fine and can be sent as a separate patch.
> >
> >> @@ -93,12 +88,31 @@ static int cpufreq_get_cur_state(unsigned int cpu)
> >>          return reduction_step(cpu);
> >>   }
> >>
> >> +static bool cpufreq_update_thermal_limit(unsigned int cpu, struct acp=
i_processor *pr)
> >> +{
> >> +       unsigned long max_freq;
> >> +       int ret;
> >> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D c=
pufreq_cpu_get(cpu);
> >> +
> >> +       if (!policy)
> >> +               return false;
> >> +
> >> +       max_freq =3D (policy->cpuinfo.max_freq *
> >> +               (100 - reduction_step(cpu) * cpufreq_thermal_reduction=
_pctg)) / 100;
> >> +
> >> +       ret =3D freq_qos_update_request(&pr->thermal_req, max_freq);
> >> +       if (ret < 0) {
> >> +               pr_warn("Failed to update thermal freq constraint: CPU=
%d (%d)\n",
> >> +         pr->id, ret);
> >> +       }
> > But this silently fixes a bug in the original code which needs to be
> > documented with a Fixes: tag (and it would be better to fix the bug
> > separately before the using the __free()-based cleanup TBH) and
> > introduces some whitespace breakage.
>
> Thanks!
>
>   I=E2=80=99ll follow your advice and handle the Fixes tag and whitespace=
 issues.

Actually, no need to resend.

The current code is correct as it registers and unregisters the freq
QoS request from cpufreq policy notifiers, so the policy is guaranteed
to be there when cpufreq_set_cur_state() runs.

