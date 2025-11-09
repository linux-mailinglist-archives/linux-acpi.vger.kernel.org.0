Return-Path: <linux-acpi+bounces-18690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B43C436E6
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 01:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90113B10A0
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 00:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8E7D07D;
	Sun,  9 Nov 2025 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZL3CKiCi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oNoe/3lK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FFAC133
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762649026; cv=none; b=LhYAsrDcKM6WiQYK09fR4wD8c37ov9QrMfTURqpHXvjHO71ygL2ltiplWffll92T65Pe0psDEUkbw9V9Q9yxm8TPl5P/uVBsh0V7dBk2pl7bLvb7jqQcbLHJlzDym7+FxLhe5pDCBs4UJhLbiWqctirUVJ4pJWh7fYL2j7qytIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762649026; c=relaxed/simple;
	bh=j9hvieHuSFNyhyyHmLJOR3dIIc9HGwU1536cyp4Qt3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=un+BUkWBmPFkN6jZ5YfEPA9SBUPbj/ZpG0iDVHS9sUlIUn8+ZXc/ObjbiFnpQetAKJYzXeukefxH4lINEWlkLVhXVX36zfb6HZikj7S5xNzDC0At0TCqeaueFFZFxt2QvuaqG0e7YYUMRFSMWqU84V14xi7DnVfuDjbzunO94oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZL3CKiCi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oNoe/3lK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762649023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQlgO5wI+SB1TvB0hi1dDNe37yfI6aj5RdkRxeRXXXc=;
	b=ZL3CKiCiAx0EDpUbU7T4Xz+o4MtF584tCIuf84h4qa5GTWC8DSvIl0B2JP60NapBqXMzh4
	aNhwtZvt6eu4d20auBSspKySJZTTKDKkgbnZFCrjqMqFeXXyWNsgJCZfRyB1VwN3hAlvLV
	WNCyIdcUB7eHjWSsv2Z21dlcP0JhqXk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-5iP8BGqVO3GSKWJy8aIM0Q-1; Sat, 08 Nov 2025 19:43:42 -0500
X-MC-Unique: 5iP8BGqVO3GSKWJy8aIM0Q-1
X-Mimecast-MFC-AGG-ID: 5iP8BGqVO3GSKWJy8aIM0Q_1762649021
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9d73d57328so1476827a12.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Nov 2025 16:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762649021; x=1763253821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQlgO5wI+SB1TvB0hi1dDNe37yfI6aj5RdkRxeRXXXc=;
        b=oNoe/3lKZTSMdx8gUjR8FkePVFiry7fqk8cFdhk/v2FCcgULMyEKWu48o5QwOjzYZk
         stdkVu+5Kr/3n5/fUqBCvKBONJT8j42WY8hD32SJYL7jqg73p8ieqK5vMerjEhprlU3F
         HtuRpqLDYfFBkTYlUWKgJ8IwOvGdhro2tRv5zbCSbEpUnsBOi2N1l17LSGHR2RRSs4Cd
         Bz2N0PIjnGO5fy2xNsBRXbgq45/JgNQopTRu4i/6jo4NOKIzdGXp0MucSdYoI6DhtYX3
         DmvtR3sC9JO8U8725KtgcPmwO5ryW7+dX4WuFW2kJAoabcGujk1G3VOdgBJffyQu3QoR
         ItjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762649021; x=1763253821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQlgO5wI+SB1TvB0hi1dDNe37yfI6aj5RdkRxeRXXXc=;
        b=ZnV0riwlI9FE17w84cmbOvxrbGERJt6L5GfVSVyUkyx6cpc/wESJ++Ahunof5LGlIP
         EU1gG1AdzksW0vfmfzyo6PX8TEEMiPDPpfj170rbFmnJRz0Cy+y22hsRyn/L9eB30QRX
         sxg4aKDbboTj3CTqTZXTkBzeAsvoSZRyrhHNOyX5DgaX742lwQiJVTAGyPr3ElNtfBid
         inaRB6lBWJulsSQDEzSiZ7X6VZ3CrLjFgw4fmzRspZgte+w2rSrCCkmhcEEnivUvli4C
         9ytGFXN+yjpjBAUw1pu2AyVjiXL0pEDvvSnktdbmOmw84wRfqZj34WA++X/45fX5PTXT
         OFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPzs50whhiF1zklqfPzadvBxGq8wSzJFCvdB/+KR9Y0pIMyPW0kzmTpOijmtl40RVGh9RG6dFiICUz@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSlGdwEoMO+reZF00/xNMORhaBd/b/w/NSwiyYV5PHHka1Dlb
	X24K/bnxrRo7r/rPG8oKs3YjV27rQNzrfgLrOEIht9MgUkPzqWADCWL00ubBhlbXaBiHdWiYvSv
	0OxVWasF4eMbiEeiUPWAOh6g7OVeKOIgcRJ7zG2Ms8ww2AcKvDf7sC8mW6Q5H/34=
X-Gm-Gg: ASbGnctgV0h5RnpYntvVffeiJ7dvrHWwHPnsMC6YBeoe07G+0OQrasHAGzqeHGFEOQA
	L1ETyERQcK2dVa6U4TS/N1ATQiJIDz0barytn6CsVdfPR6hjics/9z5uApYEfsf5sQfF6UWXr5Z
	mJkZQKMd+eeZw9tAfUnJSD172kDAnUSCwqe100nysOHk0SupWT3v/ii50TNps/4gosuXm90Yhw9
	2+wADkhaVuxMQ0N50rEytozVco4s8aA/xM4kKEJwS3U8Tke3KakWDxTyD7xioayEU3JQjqGzr5P
	HDC0As6UjsNPjR0Uq9tGa/aZhFoqEY0A2rs4imnka3fsWZecArDrGBRG4ytMIHtqG0fgVC47PL7
	YfdMCLyHWTr4ImdUaMdNeUbJ+2pWD+3p3eEyx6FI=
X-Received: by 2002:a05:6a20:1593:b0:2d5:264c:e4a1 with SMTP id adf61e73a8af0-353a11a3ea5mr5173294637.8.1762649021089;
        Sat, 08 Nov 2025 16:43:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0ivE4ma4gERSU5r6Mlvd6ro7tfXjdTpfWT/b/mxS0ym7DaXVUS6U7kla9C5us6mEn2Pc7dQ==
X-Received: by 2002:a05:6a20:1593:b0:2d5:264c:e4a1 with SMTP id adf61e73a8af0-353a11a3ea5mr5173262637.8.1762649020621;
        Sat, 08 Nov 2025 16:43:40 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bad33c80393sm5134332a12.4.2025.11.08.16.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 16:43:40 -0800 (PST)
Message-ID: <7d0c73d3-1943-469f-813a-eba1dac38d4a@redhat.com>
Date: Sun, 9 Nov 2025 10:43:27 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] arm_mpam: Probe hardware to find the supported
 partid/pmg values
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-15-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-15-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> CPUs can generate traffic with a range of PARTID and PMG values,
> but each MSC may also have its own maximum size for these fields.
> Before MPAM can be used, the driver needs to probe each RIS on
> each MSC, to find the system-wide smallest value that can be used.
> The limits from requestors (e.g. CPUs) also need taking into account.
> 
> While doing this, RIS entries that firmware didn't describe are created
> under MPAM_CLASS_UNKNOWN.
> 
> This adds the low level MSC write accessors.
> 
> While we're here, implement the mpam_register_requestor() call
> for the arch code to register the CPU limits. Future callers of this
> will tell us about the SMMU and ITS.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
>  From Jonathan:
> Stray comma in printk
> Unnecessary braces
> ---
>   drivers/resctrl/mpam_devices.c  | 148 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |   6 ++
>   include/linux/arm_mpam.h        |  14 +++
>   3 files changed, 167 insertions(+), 1 deletion(-)
> 

One comment related to 'partid_max_init', but this looks good to me in
either way:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 4162a7a57626..e1e26cb350f7 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -6,6 +6,7 @@
>   #include <linux/acpi.h>
>   #include <linux/atomic.h>
>   #include <linux/arm_mpam.h>
> +#include <linux/bitfield.h>
>   #include <linux/cacheinfo.h>
>   #include <linux/cpu.h>
>   #include <linux/cpumask.h>
> @@ -42,6 +43,15 @@ static atomic_t mpam_num_msc;
>   static int mpam_cpuhp_state;
>   static DEFINE_MUTEX(mpam_cpuhp_state_lock);
>   
> +/*
> + * The smallest common values for any CPU or MSC in the system.
> + * Generating traffic outside this range will result in screaming interrupts.
> + */
> +u16 mpam_partid_max;
> +u8 mpam_pmg_max;
> +static bool partid_max_init, partid_max_published;
> +static DEFINE_SPINLOCK(partid_max_lock);
> +

If mpam_partid_max and mpam_pmg_max are initialized to USHRT_MAX and 255 here,
the state related to partid_max_init can be removed...

>   /*
>    * mpam is enabled once all devices have been probed from CPU online callbacks,
>    * scheduled via this work_struct. If access to an MSC depends on a CPU that
> @@ -142,6 +152,70 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
>   
>   #define mpam_read_partsel_reg(msc, reg) _mpam_read_partsel_reg(msc, MPAMF_##reg)
>   
> +static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
> +{
> +	WARN_ON_ONCE(reg + sizeof(u32) >= msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +
> +	writel_relaxed(val, msc->mapped_hwpage + reg);
> +}
> +
> +static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
> +{
> +	lockdep_assert_held_once(&msc->part_sel_lock);
> +	__mpam_write_reg(msc, reg, val);
> +}
> +
> +#define mpam_write_partsel_reg(msc, reg, val)  _mpam_write_partsel_reg(msc, MPAMCFG_##reg, val)
> +
> +static u64 mpam_msc_read_idr(struct mpam_msc *msc)
> +{
> +	u64 idr_high = 0, idr_low;
> +
> +	lockdep_assert_held(&msc->part_sel_lock);
> +
> +	idr_low = mpam_read_partsel_reg(msc, IDR);
> +	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
> +		idr_high = mpam_read_partsel_reg(msc, IDR + 4);
> +
> +	return (idr_high << 32) | idr_low;
> +}
> +
> +static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
> +{
> +	lockdep_assert_held(&msc->part_sel_lock);
> +
> +	mpam_write_partsel_reg(msc, PART_SEL, partsel);
> +}
> +
> +static void __mpam_part_sel(u8 ris_idx, u16 partid, struct mpam_msc *msc)
> +{
> +	u32 partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
> +		      FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, partid);
> +
> +	__mpam_part_sel_raw(partsel, msc);
> +}
> +
> +int mpam_register_requestor(u16 partid_max, u8 pmg_max)
> +{
> +	guard(spinlock)(&partid_max_lock);
> +	if (!partid_max_init) {
> +		mpam_partid_max = partid_max;
> +		mpam_pmg_max = pmg_max;
> +		partid_max_init = true;
> +	} else if (!partid_max_published) {
> +		mpam_partid_max = min(mpam_partid_max, partid_max);
> +		mpam_pmg_max = min(mpam_pmg_max, pmg_max);
> +	} else {
> +		/* New requestors can't lower the values */
> +		if (partid_max < mpam_partid_max || pmg_max < mpam_pmg_max)
> +			return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mpam_register_requestor);
> +

With mpam_partid_max and mpam_pmg_max initialized to USHRT_MAX and 255, this
can be:

	if (!partid_max_published) {
             ...
         } else {
             ...
         }

>   static struct mpam_vmsc *
>   mpam_vmsc_alloc(struct mpam_component *comp, struct mpam_msc *msc)
>   {
> @@ -451,9 +525,35 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>   	return err;
>   }
>   
> +static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
> +						   u8 ris_idx)
> +{
> +	int err;
> +	struct mpam_msc_ris *ris;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (!test_bit(ris_idx, &msc->ris_idxs)) {
> +		err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
> +					     0, 0);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	list_for_each_entry(ris, &msc->ris, msc_list) {
> +		if (ris->ris_idx == ris_idx)
> +			return ris;
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +
>   static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   {
>   	u64 idr;
> +	u16 partid_max;
> +	u8 ris_idx, pmg_max;
> +	struct mpam_msc_ris *ris;
>   	struct device *dev = &msc->pdev->dev;
>   
>   	lockdep_assert_held(&msc->probe_lock);
> @@ -464,6 +564,40 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   		return -EIO;
>   	}
>   
> +	/* Grab an IDR value to find out how many RIS there are */
> +	mutex_lock(&msc->part_sel_lock);
> +	idr = mpam_msc_read_idr(msc);
> +	mutex_unlock(&msc->part_sel_lock);
> +
> +	msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
> +
> +	/* Use these values so partid/pmg always starts with a valid value */
> +	msc->partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
> +	msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
> +
> +	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
> +		mutex_lock(&msc->part_sel_lock);
> +		__mpam_part_sel(ris_idx, 0, msc);
> +		idr = mpam_msc_read_idr(msc);
> +		mutex_unlock(&msc->part_sel_lock);
> +
> +		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
> +		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
> +		msc->partid_max = min(msc->partid_max, partid_max);
> +		msc->pmg_max = min(msc->pmg_max, pmg_max);
> +
> +		mutex_lock(&mpam_list_lock);
> +		ris = mpam_get_or_create_ris(msc, ris_idx);
> +		mutex_unlock(&mpam_list_lock);
> +		if (IS_ERR(ris))
> +			return PTR_ERR(ris);
> +	}
> +
> +	spin_lock(&partid_max_lock);
> +	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
> +	mpam_pmg_max = min(mpam_pmg_max, msc->pmg_max);
> +	spin_unlock(&partid_max_lock);
> +
>   	msc->probed = true;
>   
>   	return 0;
> @@ -686,10 +820,20 @@ static struct platform_driver mpam_msc_driver = {
>   
>   static void mpam_enable_once(void)
>   {
> +	/*
> +	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
> +	 * longer change.
> +	 */
> +	spin_lock(&partid_max_lock);
> +	partid_max_published = true;
> +	spin_unlock(&partid_max_lock);
> +
>   	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline,
>   				      "mpam:online");
>   
> -	pr_info("MPAM enabled\n");
> +	/* Use printk() to avoid the pr_fmt adding the function name. */
> +	printk(KERN_INFO "MPAM enabled with %u PARTIDs and %u PMGs\n",
> +	       mpam_partid_max + 1, mpam_pmg_max + 1);
>   }
>   
>   void mpam_disable(struct work_struct *ignored)
> @@ -756,4 +900,6 @@ static int __init mpam_msc_driver_init(void)
>   
>   	return platform_driver_register(&mpam_msc_driver);
>   }
> +
> +/* Must occur after arm64_mpam_register_cpus() from arch_initcall() */
>   subsys_initcall(mpam_msc_driver_init);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 4e1538d29783..768a58a3ab27 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -49,6 +49,8 @@ struct mpam_msc {
>   	 */
>   	struct mutex		probe_lock;
>   	bool			probed;
> +	u16			partid_max;
> +	u8			pmg_max;
>   	unsigned long		ris_idxs;
>   	u32			ris_max;
>   
> @@ -138,6 +140,10 @@ struct mpam_msc_ris {
>   extern struct srcu_struct mpam_srcu;
>   extern struct list_head mpam_classes;
>   
> +/* System wide partid/pmg values */
> +extern u16 mpam_partid_max;
> +extern u8 mpam_pmg_max;
> +
>   /* Scheduled work callback to enable mpam once all MSC have been probed */
>   void mpam_enable(struct work_struct *work);
>   void mpam_disable(struct work_struct *work);
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> index 5a3aab6bb1d4..c7246cfeb091 100644
> --- a/include/linux/arm_mpam.h
> +++ b/include/linux/arm_mpam.h
> @@ -49,4 +49,18 @@ static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>   }
>   #endif
>   
> +/**
> + * mpam_register_requestor() - Register a requestor with the MPAM driver
> + * @partid_max:		The maximum PARTID value the requestor can generate.
> + * @pmg_max:		The maximum PMG value the requestor can generate.
> + *
> + * Registers a requestor with the MPAM driver to ensure the chosen system-wide
> + * minimum PARTID and PMG values will allow the requestors features to be used.
> + *
> + * Returns an error if the registration is too late, and a larger PARTID/PMG
> + * value has been advertised to user-space. In this case the requestor should
> + * not use its MPAM features. Returns 0 on success.
> + */
> +int mpam_register_requestor(u16 partid_max, u8 pmg_max);
> +
>   #endif /* __LINUX_ARM_MPAM_H */
Thanks,
Gavin


