Return-Path: <linux-acpi+bounces-19440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69751CA7B62
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 14:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A5332493E6
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1530AAA6;
	Fri,  5 Dec 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdtk4Ma6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AWn4r+50"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377127FD5D
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940134; cv=none; b=srPLjrIRKNHZujtAL6DAd7tpKE9jLcKkTOQSBa0204DjYR2fn3+FgKEUdzxzcPQQmFlcosP1IqqijZE3/Ks6hd5P0Y/z/OQ0GBtrS1n/r+d/mIvCuLN6paF6wzhZyx73ef0CFx39vhNbcZMepcpQMue2B2B9HGcRT1ftDvzRbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940134; c=relaxed/simple;
	bh=6K2EjrQGBJiPzI1YiE11ab9VCMGxL1xQJ8x2aOjHCpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rCfj6sIFVfl6NHvMrBoMEnhtkfwZd+Z8ZQfLeRvrTzrEYb41FJMSj/CE8f2NTvlOGCyok++cAAYzierVwCGXaZ4o3bfoVB7b+C5qcrEG+1n6uS0eebjtxJ8YMWE7K++QahmBe3A9aWfNHXlw7Sv4Y6fSurr9c4OrRFT30cvqPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdtk4Ma6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AWn4r+50; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B596JRB2896899
	for <linux-acpi@vger.kernel.org>; Fri, 5 Dec 2025 13:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aJNZlqMyVpKqCVauRzrnOtmM
	cjDznFVaeApZ23rdtJQ=; b=jdtk4Ma60YUKV/uVdaOGpuNZS0SdVyoAHNOogZnA
	b4m1hBNXgYSzExerCqlvPC49B5Ehr7YfhzMwiNSfQGgfHq99ygdWQvkCjQU4hGkv
	wEoZr0HO4F7efWkhzHWcmdKAVIp0d9DOUx75lH8YDfTD5oYKRvoa6WGlfRGY8ZAD
	j+CwXqCWelgHlSM1D5TLlv+IRTyLrOrJeH+7oyUSAXC/U0dwzfmt4m2nXBnuMFBX
	a0R7Fit8RGqOX/oR3wQD5cfaPT2gN5wyKaWCp9leTYOwQrs5GnsxJa5KjORwhr81
	0QqvhzQPirqFY6hORkSZwm+lnfceTlbwEKjuuGN8jlA+HQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aukmj22bv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 13:08:43 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9371a5de34bso3255807241.2
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764940123; x=1765544923; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJNZlqMyVpKqCVauRzrnOtmMcjDznFVaeApZ23rdtJQ=;
        b=AWn4r+50J5//8eul3rhzWzytNehm4F+TaTMKnOnnMqd3oUphvXCcYOtrk3lQPudhJ4
         UE4ZHMPY7fvCAr+BtXSMiLbSytoJ3maXM40PpR0VVAgbkgYH+1nHuCgg6xHdp9+12kb1
         5XP4XE485oBouL3CrYlUNsYmcv3x9VfxpXu/bkHfmwOESHEIT8xj9nfeJAmEC7vKK+MJ
         1RbblncUGLydureANde4AS9AJEH78dLWqY26b9D5Fav9fiz9VjXeHIo9ECur40gJRCov
         kVd7a5HhA0qBiAxbTbQHA3t5hIIyD9nAbUIesZjS6crYgYE5rrHgPppdZ1deFhMuqup6
         XICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764940123; x=1765544923;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJNZlqMyVpKqCVauRzrnOtmMcjDznFVaeApZ23rdtJQ=;
        b=vuIAkEhFfxkYg/SM2FRMWfYnH2pMtQs5ywaH9wl+SBJhbmuFkWYbgaWykQC2erLmUU
         /aQXX4nfrT0vvR4PYKYZk171RcZ4431Z9lKvhyWwxrnIDlYik0XDkgCumVYkp8gyRVXk
         AWr/mxCBVDfqLovQGRMVV1ApYp8/GBodKe55jcCOE9ClLm/J94BgaA5PNmtXPrJljtE9
         khhMy1aI6SRuJATgLa6m9OYihp3oyf5l34t63o5oPX4hnV7KmWANdKqn1GZe2AihqMAP
         cEoh5evH3oEZWUG4D8iqAOyF7NKZ/RiEu4udRxKjI35exLWoPI9TyPk3NxyNx5q20O9q
         q19A==
X-Forwarded-Encrypted: i=1; AJvYcCW8dJzJw/3Oq+rKSzBANitSBdToDUB6FlByxYOnTpGCg7UWURttVheM9i8mPJrT3k7xWOInxNPXXB9O@vger.kernel.org
X-Gm-Message-State: AOJu0YySddIHW2n7fn20Z34xvPsMG7ot48tigfPu5s+0pW4Uo47R6FPU
	FrQlVxETEuD+dpNRalu0tqnoMXz9GBlsOBzqVPREvK/+MnO7P0VAg7vpvkcrSxUBGeYsfJugXm0
	HfVs15aIqVvJ4KZn6qZbrDmGRsF0aH6r0fShCtNPeow1EMUAfddeiW8RAX7jlDFNM
X-Gm-Gg: ASbGnct7XIWFYh/3gquablHoHsqaxhL19kHVSrNp+/GVNgmUKSX4nwoOJXxUzMAlfoZ
	c/uhLTiC84xVE1eKhS8esItU/gVl7h4tcbVfv9yS56ZIOQLmlAxu0Nmnf1at5LhuzceBKzOgB4n
	svFO3zIZ4+1iO1ZLLFk5Gc6u4Nk8fwcktFluQMJ8ngKPcQIr0XEJvXkGM/AivwOHYripNRvhuNt
	fKeHep7GbXh6lAcxu9yHpsWauhCYAHSUEbyT1fh5vFx/lgMctaqA3+pxUcwqfj3R1Pnp/QIjL0D
	CK/eccCRr9ClTDs44ZLeNHPPu43iuRJ1B3Ahstl+LtlssGLpK8WTmwlyFiNACXlxRHOXVr+H/eX
	IxoY9sVyvCK7aSuJ+AzbOe1rh
X-Received: by 2002:a05:6102:5818:b0:5e1:866c:4f7c with SMTP id ada2fe7eead31-5e48e3d3c32mr3751058137.39.1764940122616;
        Fri, 05 Dec 2025 05:08:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoVFLXE/I17RgN98+gHQViOk7KSVZOb5/MXqt1hrIeWuM9v9uKcV9QR6B6Q6gd7CA/qJwGVQ==
X-Received: by 2002:a05:6102:5818:b0:5e1:866c:4f7c with SMTP id ada2fe7eead31-5e48e3d3c32mr3751005137.39.1764940122130;
        Fri, 05 Dec 2025 05:08:42 -0800 (PST)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47930c76edcsm82740975e9.11.2025.12.05.05.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 05:08:41 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: James Morse <james.morse@arm.com>
Cc: Punit Agrawal <punit.agrawal@oss.qualcomm.com>,
        Ben Horgan
 <ben.horgan@arm.com>, amitsinght@marvell.com,
        baisheng.gao@unisoc.com, baolin.wang@linux.alibaba.com,
        bobo.shaobowang@huawei.com, carl@os.amperecomputing.com,
        catalin.marinas@arm.com, dakr@kernel.org, dave.martin@arm.com,
        david@redhat.com, dfustini@baylibre.com, fenghuay@nvidia.com,
        gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
        jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
        lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
        rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
        scott@os.amperecomputing.com, sdonthineni@nvidia.com,
        sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org,
        xhao@linux.alibaba.com, reinette.chatre@intel.com
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
In-Reply-To: <642767c9-f926-490a-83a1-160978c37553@arm.com> (James Morse's
	message of "Wed, 3 Dec 2025 17:34:37 +0000")
References: <20251119122305.302149-1-ben.horgan@arm.com>
	<877bvfa23i.fsf@stealth>
	<a04aa337-a3eb-42a0-855b-500ba549e2d8@arm.com>
	<87sedrlsjk.fsf@stealth>
	<642767c9-f926-490a-83a1-160978c37553@arm.com>
Date: Fri, 05 Dec 2025 13:08:40 +0000
Message-ID: <871pl9krdz.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bYtmkePB c=1 sm=1 tr=0 ts=6932d95b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8
 a=aZ4QdqtX2bFftAu5rtMA:9 a=TOPH6uDL9cOC6tEoww4z:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 3KcYYsryLQj1M2nfQreFc910rG2xgPk0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA5MyBTYWx0ZWRfXy0kDRMiNCn+6
 Ai3Fsp4BMJwgoNPciY9KaseYYrFmTdcEvwAjPsvjFCXeZdRx23kPdR6/4YewRSZnI9EXMWgANxI
 ZsiCl9yxHZPOVkYqmxcYbU/mN6Kuv5f5D2SdyxQIdlk5JPUIWt1fA2vKAP7WUBygCxtNh8WkoVD
 2QbKaFJwuk5sjZl/FL3PN3+5koG/YdDNg9/ITbEx74x0BfW1q//DK3Ubb6Mu+/Uuvj/vXLMI82G
 +bd5asVETzA6yUHZZF4z5lyB38H6IYBEdrYiKeLyQUzYXxzPZaJ6xhPdkU/GJQkFd5fNPQGYsvN
 4d4pi/pbEGnMj0TpbIv0INF29NL2l4mnBkClPV9V0LhcKocQIfC4D1FVDF3MA7zYzqROdh1h3gE
 mdawHi3QUhh8G9Mlw1WHYstHlso+8w==
X-Proofpoint-GUID: 3KcYYsryLQj1M2nfQreFc910rG2xgPk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050093

James Morse <james.morse@arm.com> writes:

> Hi Punit,
>
> On 03/12/2025 11:21, Punit Agrawal wrote:
>> Ben Horgan <ben.horgan@arm.com> writes:
>>> On 11/24/25 15:21, Punit Agrawal wrote:
>>>> Although a little late to the party,
>
> There was a party?!
>
>
>>>> I've managed to throw together
>>>> enough firmware to describe the MPAM hardware and take this set (more
>>>> specifically mpam/snapshot/v6.18-rc4-v5 branch from James' repository)
>>>> for a spin. Using the branch, the kernel is able to probe the hardware
>>>> and discover the advertised features. Yay! We are in business.
>>>
>>> Thanks for giving it a go. :)
>>>
>>>>
>>>> Having said that, there are a few quirks of the platform that run into
>>>> issues with later patches in the branch.
>
> So something in the resctrl support code is causing this.
> Any idea which patch causes this to happen?
>
> There are a load of pr_debug() in the picking logic, if you enable DYNDEBUG and add:
> | dyndbg="file mpam_resctrl.c +pl"
>
> to the commandline, you should get some snotty messages about what non-Xeon-like property
> your platform has.

Thanks - I've got this enabled.

The platform looks very different to a Xeon. One notable difference
being a shared L2. Hence all the MSCs attached there.

>>>> The platform has MSCs attached
>>>> to shared L2 caches which are being skipped during later stages of
>>>> initialisation. IIUC, the L2 MSCs' limitations stems from the
>>>> assumptions in the resctrl interface.
>>>
>>> What in particualar is being skipped?
>
>> The registration of the discovered MSCs with resctrl and subsequent
>> exposing it to the user.
>
> resctrl's 'L2' support is limited to the CPOR bitmap.
> If you have controls, there is no resctrl 'event' that can exposed them.
> (the problem being they all have 'L3' in the name!)

>>>> I was wondering if there are any patches available to relax these
>>>> limitations?

> Knowing which property it is will help - but some of these things are checked
> to match resctrl's ABI. They can't necessarily be relaxed without breaking
> user-space.

This platform has portion, capacity and priority partitioning, as well
as memory bandwidth and cache storage monitoring. The MPAM code seems to
correctly parse the properties.

But as you point out, the resctrl 'L2' support doesn't have anything
other than CPOR bitmap yet. Have you looked at what's needed to extend
resctrl to support some of the others?

> Others are sanity checks, e.g. all CPUs are represented. This is to avoid tasks
> that run on cpu-9 escaping the resctrl controls. Platforms that did this may as
> well not bother with resctrl at all.
>
>
>>>> I can give them a try. Or do these need to be put together
>>>> from the ground up? Any pointers greatly appreciated.
>>>
>>> There are some extra things added in the extras branch [1] e.g. cache
>>> maximum usage controls (cmax). However, lots of possible things are
>>> still missing e.g. any monitors on L2. If it doesn't fit with the
>>> topology expected by resctrl then it is unlikely to have been considered
>>> yet.
>> 
>> Thanks for the pointer. I'll give the snapshot+extras branch[1] a try.
>> 
>> The platform does have both controls and monitors attached to L2. If
>> this isn't being looked at, I can try and put something together. Thanks
>> for confirming that the limitation is likely due to resctrl.
>
> My view on 'extra' counters is to try and expose them via perf, as this would also
> allow platform specific counters. I worry that if we start adding 'easy' ones like
> l2_mbm_total to resctrl, someone will want
> left_hand_side_of_soc_mbm_total.

I wouldn't club L2 in the same category as 'left_hand_side_of_soc'. You
call it 'easy' for a reason. L2 is pretty well understood and resctrl
already exposes an interface for it. I would avoid creating a new
interface for users.

For some of the other boundaries, things like 'left_hand_side_of_soc' I
wonder if firmware provided topology (e.g., PPTT, SRAT, etc) could be
used to make even this work.

