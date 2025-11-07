Return-Path: <linux-acpi+bounces-18623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8EFC3F7B8
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 11:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B893B54A8
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658331A803;
	Fri,  7 Nov 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wgebvh8i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB5305E08
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511419; cv=none; b=gRp46/UEt0ySL64U9d6ODVDkGNQfyPzPMHhkG4us3bCki11IhXXY35wHj8r21xJWMc9hXSZ80k5dWvw46s2TDYAW1an4cM8WfdL6qUza/J2xMD3jG77on8+0S2vcrBUcfwLn6hdgjZw/i9RHX2tEx1ya3YLwB8jU4USGnj24Sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511419; c=relaxed/simple;
	bh=obmvNhNSljc4hcgnWD69M7W8r+dV980c55d+Sxx1WKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFVu06OUML6Sk8RCDMiqubbCU+JLgy/ShEspvhtikBFQq9zYGxQV1Jvjs927ICJEEW+0u7xphB0LUyj/hFTQWE6ybHr746rQ837r3grfx1kKUXAcIPi3bnGPYOgMJ1g9ZKOoak8vZP3xjDrDkp7AgWWOWGYf+ccyHfWwoxjchMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wgebvh8i; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7277324204so97106766b.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2025 02:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762511412; x=1763116212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No6GwKzJfCCDDPKQIQxrIKzPon7QFA7coiXs9eLOLXY=;
        b=Wgebvh8iEKlC9rklGbL8DSlL/vsOvw84O8Vh7s0nMLaUR4veRrDo7wRSeyhH279iQb
         wehVlgnA0oTJMWI0sR8Rae++uqt3GLQmpKjTBTki1zyLUqchXH8P0aCyR7apllK4yE+D
         JHso1OI4jC48dW4i2YiFNHZc8g2mLF35NMIgHN94Lv8BaBk/ZqjCg9InBP7z5GkUAmNf
         +Rldzx11A2EV9SIqIa4m1TenUBtfPmA5D3McpBTVuKllN/C5k6Wf9kZWpxKZfU3/wrf/
         buy35TheeDaA56+qfN/qlb39jndSA8OGy8/Goi8aON4eHYfHAdfBnxDlDve7PYjZjwfE
         JNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511412; x=1763116212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=No6GwKzJfCCDDPKQIQxrIKzPon7QFA7coiXs9eLOLXY=;
        b=jt9FrdQSm/ENb/DfvrqdlLUAr19pbHgvCIXol/Ew7zCNCooyBoVle1JEP2tnFER80z
         viKFMS2bArV3eLRNy2fajPbPJmwd073CZYQ1mfjtigKRTb3wYiULAw62CpRhIV8etnIP
         8+VuaNorFacSm0rA5GqF0Q/JQs915OPo8vcLgdZHP9tLc/OWJKtulqvIf/51jYuD0j+/
         vzzpx5kVNp569WQ0N1qB9gb5NqRpSlZKVIEL7GG7oWzwDM+kBCv2UsWy/L27hk/oFlXW
         QYVNvnqmuBoc8PYlv27e+WanoA0K5ulZivzl1MkUUWnMBFKK7p7LaK/y1JD+KCB9qzPH
         Zn+A==
X-Forwarded-Encrypted: i=1; AJvYcCVxxsy5Qh3m0Rb/j8sZS57IvTVJSHbXcx6DnXDJEHBxqhaTzIWnhOpsiNidnMAevKxWLGl1Sl8n18Ng@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMNEXxSTfBksREwLRNIATJv+dyDEvCCYMZuj7J/AgVWGB2Ux5
	QvALAWp+ZEuOMdvNUl64NiulMLTVvHq2jQNUILQKS3c3qDkfFWSrGyBx5fO1Eika3fTVafvxPIA
	6SROQZQDZewEbkCeTxmwfCv1HWNAaqOJY1AYR0EGq
X-Gm-Gg: ASbGncsxtdggtcKTRvNxBQ0zEJmTrV94cf6rGrwVGVDXg4ZkJyLDyoB5qGRwoKFRwTN
	izHAhjln6KeyFpIymK5shI4DKuK5V2L7GvvcWqjBKcxlOox+gQ/acv9IS3tD2T/ZIoH8qDG1k+b
	bPb/W3uhKBh/zRpoyIxT9gJg3hPCEOBjBURTgK0QCGns53iNPSP3nD9G2m9SPg/neH0HTIjMKBE
	kbv4YQmWC8cMqi5xYArfe36/KwtdxFf+j7qOzZrEi3tUbMPsQo9dxDK1M5s06dwTz+QBi6sz15F
	uS9r9t6xRHXG0gMphKECngG9CQ==
X-Google-Smtp-Source: AGHT+IG30tRXexX+8frHnHjuclcK9+qrxNelFybJrdVL6a5BhtuhdUQJ6TpMRhSTiHHcagf2YAhFzsm/Fo0hqvK7D9E=
X-Received: by 2002:a17:907:60cc:b0:b72:5f93:2959 with SMTP id
 a640c23a62f3a-b72c0ad3420mr268316166b.17.1762511411448; Fri, 07 Nov 2025
 02:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017185645.26604-1-james.morse@arm.com> <20251017185645.26604-27-james.morse@arm.com>
 <CALPaoCjJXHD+HgFizzvNEvBorbUcJLTngLb7UJy-uMdybhCfrg@mail.gmail.com> <9e2f912d-2a2e-49ed-b0ab-4286fe94e145@arm.com>
In-Reply-To: <9e2f912d-2a2e-49ed-b0ab-4286fe94e145@arm.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 7 Nov 2025 11:30:00 +0100
X-Gm-Features: AWmQ_bmT_xoyb-k1HQ7hjOxxQERbHJYcErtYbLBLJOgCOM__r3wTvrdClo_rpzo
Message-ID: <CALPaoCg7ZeQOgkeaPQ6ERKtaJqQ_n3xQUrK=qxi01CnuTjL4PA@mail.gmail.com>
Subject: Re: [PATCH v3 26/29] arm_mpam: Use long MBWU counters if supported
To: Ben Horgan <ben.horgan@arm.com>
Cc: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com, 
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com, amitsinght@marvell.com, 
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com, baisheng.gao@unisoc.com, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring <robh@kernel.org>, 
	Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben

On Thu, Nov 6, 2025 at 5:41=E2=80=AFPM Ben Horgan <ben.horgan@arm.com> wrot=
e:
>
> Hi Peter,
>
> On 11/6/25 16:15, Peter Newman wrote:
> > Hi Ben (and James),
> >
> > On Fri, Oct 17, 2025 at 8:59=E2=80=AFPM James Morse <james.morse@arm.co=
m> wrote:
> >>
> >> From: Rohit Mathew <rohit.mathew@arm.com>
> >>
> >> Now that the larger counter sizes are probed, make use of them.
> >>
> >> Callers of mpam_msmon_read() may not know (or care!) about the differe=
nt
> >> counter sizes. Allow them to specify mpam_feat_msmon_mbwu and have the
> >> driver pick the counter to use.
> >>
> >> Only 32bit accesses to the MSC are required to be supported by the
> >> spec, but these registers are 64bits. The lower half may overflow
> >> into the higher half between two 32bit reads. To avoid this, use
> >> a helper that reads the top half multiple times to check for overflow.
> >>
> >> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> >> [morse: merged multiple patches from Rohit, added explicit counter sel=
ection ]
> >> Signed-off-by: James Morse <james.morse@arm.com>
> >> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> >> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> >> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> >> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> >> ---
> >> Changes since v2:
> >>  * Removed mpam_feat_msmon_mbwu as a top-level bit for explicit 31bit =
counter
> >>    selection.
> >>  * Allow callers of mpam_msmon_read() to specify mpam_feat_msmon_mbwu =
and have
> >>    the driver pick a supported counter size.
> >>  * Rephrased commit message.
> >>
> >> Changes since v1:
> >>  * Only clear OFLOW_STATUS_L on MBWU counters.
> >>
> >> Changes since RFC:
> >>  * Commit message wrangling.
> >>  * Refer to 31 bit counters as opposed to 32 bit (registers).
> >> ---
> >>  drivers/resctrl/mpam_devices.c | 134 ++++++++++++++++++++++++++++----=
-
> >>  1 file changed, 116 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_dev=
ices.c
> >> index f4d07234ce10..c207a6d2832c 100644
> >> --- a/drivers/resctrl/mpam_devices.c
> >> +++ b/drivers/resctrl/mpam_devices.c
> >> @@ -897,6 +897,48 @@ struct mon_read {
> >>         int                             err;
> >>  };
> >>
> >> +static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
> >> +{
> >> +       return (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris-=
>props) ||
> >> +               mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris-=
>props));
> >> +}
> >> +
> >> +static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
> >> +{
> >> +       int retry =3D 3;
> >> +       u32 mbwu_l_low;
> >> +       u64 mbwu_l_high1, mbwu_l_high2;
> >> +
> >> +       mpam_mon_sel_lock_held(msc);
> >> +
> >> +       WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage=
_sz);
> >> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->acces=
sibility));
> >> +
> >> +       mbwu_l_high2 =3D __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> >> +       do {
> >> +               mbwu_l_high1 =3D mbwu_l_high2;
> >> +               mbwu_l_low =3D __mpam_read_reg(msc, MSMON_MBWU_L);
> >> +               mbwu_l_high2 =3D __mpam_read_reg(msc, MSMON_MBWU_L + 4=
);
> >> +
> >> +               retry--;
> >> +       } while (mbwu_l_high1 !=3D mbwu_l_high2 && retry > 0);
> >> +
> >> +       if (mbwu_l_high1 =3D=3D mbwu_l_high2)
> >> +               return (mbwu_l_high1 << 32) | mbwu_l_low;
> >> +       return MSMON___NRDY_L;
> >> +}
> >> +
> >> +static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
> >> +{
> >> +       mpam_mon_sel_lock_held(msc);
> >> +
> >> +       WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage=
_sz);
> >> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->acces=
sibility));
> >> +
> >> +       __mpam_write_reg(msc, MSMON_MBWU_L, 0);
> >> +       __mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
> >> +}
> >> +
> >>  static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> >>                                    u32 *flt_val)
> >>  {
> >> @@ -924,7 +966,9 @@ static void gen_msmon_ctl_flt_vals(struct mon_read=
 *m, u32 *ctl_val,
> >>                                                ctx->csu_exclude_clean)=
;
> >>
> >>                 break;
> >> -       case mpam_feat_msmon_mbwu:
> >> +       case mpam_feat_msmon_mbwu_31counter:
> >> +       case mpam_feat_msmon_mbwu_44counter:
> >> +       case mpam_feat_msmon_mbwu_63counter:
> >>                 *ctl_val |=3D MSMON_CFG_MBWU_CTL_TYPE_MBWU;
> >>
> >>                 if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ri=
s->props))
> >> @@ -946,7 +990,9 @@ static void read_msmon_ctl_flt_vals(struct mon_rea=
d *m, u32 *ctl_val,
> >>                 *ctl_val =3D mpam_read_monsel_reg(msc, CFG_CSU_CTL);
> >>                 *flt_val =3D mpam_read_monsel_reg(msc, CFG_CSU_FLT);
> >>                 return;
> >> -       case mpam_feat_msmon_mbwu:
> >> +       case mpam_feat_msmon_mbwu_31counter:
> >> +       case mpam_feat_msmon_mbwu_44counter:
> >> +       case mpam_feat_msmon_mbwu_63counter:
> >>                 *ctl_val =3D mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
> >>                 *flt_val =3D mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
> >>                 return;
> >> @@ -959,6 +1005,9 @@ static void read_msmon_ctl_flt_vals(struct mon_re=
ad *m, u32 *ctl_val,
> >>  static void clean_msmon_ctl_val(u32 *cur_ctl)
> >>  {
> >>         *cur_ctl &=3D ~MSMON_CFG_x_CTL_OFLOW_STATUS;
> >> +
> >> +       if (FIELD_GET(MSMON_CFG_x_CTL_TYPE, *cur_ctl) =3D=3D MSMON_CFG=
_MBWU_CTL_TYPE_MBWU)
> >> +               *cur_ctl &=3D ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
> >>  }
> >>
> >>  static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
> >> @@ -978,10 +1027,15 @@ static void write_msmon_ctl_flt_vals(struct mon=
_read *m, u32 ctl_val,
> >>                 mpam_write_monsel_reg(msc, CSU, 0);
> >>                 mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMO=
N_CFG_x_CTL_EN);
> >>                 break;
> >> -       case mpam_feat_msmon_mbwu:
> >> +       case mpam_feat_msmon_mbwu_44counter:
> >> +       case mpam_feat_msmon_mbwu_63counter:
> >> +               mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
> >> +               fallthrough;
> >> +       case mpam_feat_msmon_mbwu_31counter:
> >>                 mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
> >>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
> >>                 mpam_write_monsel_reg(msc, MBWU, 0);
> >
> > The fallthrough above seems to be problematic, assuming the MBWU=3D0
> > being last for 31-bit was intentional. For long counters, this is
> > zeroing the counter before updating the filter/control registers, but
> > then clearing the 32-bit version of the counter. This fails to clear
> > the NRDY bit on the long counter, which isn't cleared by software
> > anywhere else.
> >
> > From section 10.3.2 from the MPAM spec shared:
> >
> >  "On a counting monitor, the NRDY bit remains set until it is reset by
> > software writing it as 0 in the monitor register, or automatically
> > after the monitor is captured in the capture register by a capture
> > event"
> >
> > If I update the 63-bit case to call
> > mpam_msc_zero_mbwu_l(m->ris->vmsc->msc) after updating the
> > control/filter registers (in addition to the other items I pointed in
> > my last reply), I'm able to read MBWU counts from my hardware through
> > mbm_total_bytes.
> >
> > Thanks,
> > -Peter
>
> Thanks for the testing and flagging the problem. We should do the
> configuration in the same order for all the monitors.
>
> I'll change the case to:
>
>         case mpam_feat_msmon_mbwu_31counter:
>         case mpam_feat_msmon_mbwu_44counter:
>         case mpam_feat_msmon_mbwu_63counter:
>                 mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>
>                 if (m->type =3D=3D mpam_feat_msmon_mbwu_31counter)
>                         mpam_write_monsel_reg(msc, MBWU, 0);
>                 else
>                         mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
>
>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_=
CFG_x_CTL_EN);
>                 break;

I tried this out but wasn't able to read the counters. I needed to
move the MBWU[_L] write to the end. Writing the registers directly on
the hardware I'm testing with, I confirmed that just flipping
MBWU_CTL.EN sets NRDY:

MBWU_L=3D0x880
MBWU_CTL=3D0x828

 / # mmio_read32 $((msc + MBWU_CTL))
0x80030042
 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x03ecb2c0
0x00000000
 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x03f70580
0x00000000

Clear MBWU_CTL.EN:

 / # mmio_write32 $((msc + MBWU_CTL)) 0x00030042
 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x05004680
0x80000000
 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x05004680
0x80000000

Clear NRDY and reenable MBWU_CTL.EN:

 / # mmio_write32 $((msc + MBWU_L)) 0; mmio_write32 $((msc + MBWU_L + 4)) 0
 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x00000000
0x00000000
 / # mmio_write32 $((msc + MBWU_CTL)) 0x80030042
 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x001dee80
0x80000000

In fact, re-writing the same value back into MBWU_CTL.EN also sets NRDY:

 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x00253e00
0x00000000
 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x00b1a6c0
0x00000000
 / # mmio_write32 $((msc + MBWU_CTL)) 0x80030042
 / # mmio_read32 $((msc + MBWU_L)); mmio_read32 $((msc + MBWU_L + 4))
0x018d1d40
0x80000000

Thanks,
-Peter

