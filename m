Return-Path: <linux-acpi+bounces-19407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D5C9ED4B
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 12:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DEE3A21A4
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD02F1FE3;
	Wed,  3 Dec 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRd/6IjJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J4eDP4Ku"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B6279907
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764760900; cv=none; b=B6PMbyrNvPfuy+KxE3NrsAxaCzfr/QOmvVgwaBN35JVZQrz1zs0syPp7vG3uWMrComUIvpIHi82ORHXMyocAy+rJ+xQnjUsgTbuy6dpTWEz/+z2Q9o0da0Va1Gg/CL5869Xs993B2O50sXbxfZ+Df+tzzWKF/yigLL+nKMKAcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764760900; c=relaxed/simple;
	bh=Gox/d8cXZUptuYRz4J7tDFXVAsBnBjlIu/d8Xj9Ged8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZjD/YjGtyVOAlevBQagh3Cy8KiMdjEw7LTYeaT5QNtHdtGKupQiAwQSk4BkIhv0qOVeEIyXfBL4aF4d8KO81UFfDDPIMrlLhpMdRgiaNrhnHvkadvIJuEDXu5kAhUgDZyRGtrmgMYRpgv9DCH8HD8x1mwukuQye7LrJZUMHt2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRd/6IjJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J4eDP4Ku; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3B5f6g385375
	for <linux-acpi@vger.kernel.org>; Wed, 3 Dec 2025 11:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qHwr2aYkPOpOXz+3A1uAi5MY
	7m5P4Mot0muCw/X+iyA=; b=WRd/6IjJqKUtkElp1S8rYCIxYrYPs76aUZSaLv2t
	9MFXfxS/1zc7ZeTydAhmgbBWXUBa27P4bkYJ647VgNP4v4TvxPmvt5XDZ7+1rhvM
	NKhH34Mhs/MAvoN/TdEqJ/QcchBvqn3ZVdxM8QHUc22mRiVGWIJtgQsovViqcljw
	DSAXNvEbwAQR1rs/sOIw0aSl4+XYPfcFarO1d2J2smFcaZwW14E8adoo70A62q+N
	lH3bdTD8jBiWrEz8VouVaj8Bh+zz2jVrl1N+RZLtDHWh6ExvfOUuRjYUq1iLjwUL
	o23sg5lizknJGUYIWygRIpVD/D2dWRzbZKhmnXzcrsstEQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4at5db2sg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2025 11:21:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2e235d4d2so942928985a.3
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2025 03:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764760897; x=1765365697; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHwr2aYkPOpOXz+3A1uAi5MY7m5P4Mot0muCw/X+iyA=;
        b=J4eDP4KuPoExkCmwD5sfESD02b7NWpRvghngCScZcTiFTjwMn6fHryiT5ewwoCkQE6
         7osHoIQdOIwxvSczCCdeoB5/sgHZyd02VtA+JtFtjQ1JNbojNuX5qGRknCmh+fWY/Xsn
         7MWNP9kv1n1QzedF2RwLF7MJK6cRnf/TMBlVxlB3OqGooKrKvO/+mDlGitp1VyndC/Hx
         yYMFVsdYaUD1BUdRMMyvst+Lirn+u2Cq1rzNqYadWkKYFanqrFR68jQcjV4Vy9+WZSpH
         yyi5FgMV3GhqlveYhaAyJFEgrD/888yyZQ4+jsQtzcCiMwy0zzg5/WzFbvS/7gAPGZKU
         9Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764760897; x=1765365697;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qHwr2aYkPOpOXz+3A1uAi5MY7m5P4Mot0muCw/X+iyA=;
        b=dUy3fOXCI2mUbWw5tHs8hU59pCCqLfHXYxhQGMNKIKzjGNg/aLJ7vSa2pAkZJrAuUI
         QjPiSDMkhWINAwLBRRtRFeCm4RHhyU0553tiHqz0tJUpjhQL5r0RX9k16XVMDI9YHqbd
         fpkfAGB27VNgV1h9jTherw/T76Ozp3fKSc7bNx5UqlUX0qbQ2waHJ6IW5HUIqVc9D8t2
         eZMA/mnzqg/Bth1wh6zqqOVzQNXOPaUEFZG1UF2kpe+B4GWKdw0mAchqum656uuK9Zbq
         lxt2baXi2T+Ss4wQEZyRNmGMtG56bYr9CdBiK1f0r4Koi3j2Xe4G8Q/UtHK/A1dDYizo
         Cf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQ57Zr1Z4hp77UqasXc5LPkFebvlfalmlM0ZkVTXK8m9TfgugfOG+QEWvVjfoKGJkd1b9J9I9qNN3b@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcc/c8SSi94IiVYr8bxnRyOznbvA1Be32f51ZHoOiMcs+LrJ4r
	On+BgTdNSXlH0IOtptb1vh0EqUtxz6yzS1imAe/hBId61fSi7TfoIQtwK8G8+nuJckt8JoRBOwi
	rppzhmPOtscjYrof9aB2IpA0MqCs0aKlTKqSqYiX5k48OM142PaPO/S8YSwr9c5kcLXt8ECRtaF
	s=
X-Gm-Gg: ASbGncuF4YdUq8odLduifOB/HWL0T+oYA3NaB/q0mBId1tByvmH1/slyp44vCTRXxNJ
	NSTiFPU/fF3A0V07QD3U9a5gaP5ToioUFp0uMVy/RyS6coyubDLeZKuutQRI7lCp+wYn1MCgiRx
	wDtJ3jiiI8MnreZK6Xw/L27Q2BYGYWF/J2adOiYT35jQkp2SLZHXBWT7fgv4c5QGFhvopLyN55N
	ghtmzCtq3HOTFASJZ0rQCjIKjhGTSPLz5QEIeqkVhyvLeczcXvegl32dKkcDscAxXmxt2fPUTK2
	MOcQbu3eFp5KlOUDF2oxoPGLgR61ZKpoZEPOuT7NvciMzSHW8FGabhnhFzLPFdTkO40nsTPYMnl
	Q69ld/zPDJPUwTZatlUWi/hkE
X-Received: by 2002:a05:620a:4012:b0:891:cc30:1018 with SMTP id af79cd13be357-8b5e6f7b158mr221751385a.71.1764760897379;
        Wed, 03 Dec 2025 03:21:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/Y19mgYxD4KaBhwc+HBpSK1pF0dusgLAuMRTn6UAA+2Nf0w2GPbIuNQMeW046bslWwQgiAw==
X-Received: by 2002:a05:620a:4012:b0:891:cc30:1018 with SMTP id af79cd13be357-8b5e6f7b158mr221748485a.71.1764760896850;
        Wed, 03 Dec 2025 03:21:36 -0800 (PST)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4792a8ccdfbsm43945665e9.14.2025.12.03.03.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:21:36 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: Punit Agrawal <punit.agrawal@oss.qualcomm.com>, james.morse@arm.com,
        amitsinght@marvell.com, baisheng.gao@unisoc.com,
        baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
        carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
        dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
        fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
        guohanjun@huawei.com, jeremy.linton@arm.com,
        jonathan.cameron@huawei.com, kobak@nvidia.com, lcherian@marvell.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
        rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
        scott@os.amperecomputing.com, sdonthineni@nvidia.com,
        sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org,
        xhao@linux.alibaba.com, reinette.chatre@intel.com
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
In-Reply-To: <a04aa337-a3eb-42a0-855b-500ba549e2d8@arm.com> (Ben Horgan's
	message of "Thu, 27 Nov 2025 14:25:28 +0000")
References: <20251119122305.302149-1-ben.horgan@arm.com>
	<877bvfa23i.fsf@stealth>
	<a04aa337-a3eb-42a0-855b-500ba549e2d8@arm.com>
Date: Wed, 03 Dec 2025 11:21:35 +0000
Message-ID: <87sedrlsjk.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zb9oMgBZYuiD1wZicBLQvhTezk9w09HS
X-Proofpoint-GUID: Zb9oMgBZYuiD1wZicBLQvhTezk9w09HS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA5MCBTYWx0ZWRfX75TGQzXSB2ZQ
 Ion/lhYBh3z95ozwWd+TsQRM7MB/fu6LpZgdNHweMEqIuBZ7IZxBmSKl/Igqj+elNI/HYNStAaY
 pT9ilQwAGPyXYCusnyQ7fwkAAm417/MdonCUTPTaqmckEd8A4foUfgzBAxnZBXjLlxTPAjl5Wk9
 VCqeVt5hLHcqCc6IqtMRXepdVxp9ruh6NRCZr0E1VmYs6m67NLX6z9XxWwK+deNhzWSLcmU+haK
 N9viBvR7/1/hAPAR4rIADB47kNl+vrSuH62GgJUHrvO2heVngH5bRQfn4jpl1HtN5odBOsU+3d2
 hQACdnNjNqMu1GhonwT11yNBkPN69YP/QUeM5QX1OyC/kMgUsHUFknobo6lTgzkhty3N6cam8pd
 zsUnsbQsT6Z6MOJmwLVZbEt7wcXcSQ==
X-Authority-Analysis: v=2.4 cv=VoMuwu2n c=1 sm=1 tr=0 ts=69301d42 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=2TOxWa3ygJBVc2Mkyu0A:9 a=PEH46H7Ffwr30OY-TuGO:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030090

Hi Ben,

Thanks for getting back.

Ben Horgan <ben.horgan@arm.com> writes:

> Hi Punit,
>
> On 11/24/25 15:21, Punit Agrawal wrote:
>> Hi Ben, James
>> 
>> Ben Horgan <ben.horgan@arm.com> writes:
>> 
>>>
>>> This series is based on v6.18-rc4, and can be retrieved from: (no v6 version)
>>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v5
>>>
>>> The rest of the driver can be found here: (no v6 version)
>>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc4-v5
>>>
>>> What is MPAM? Set your time-machine to 2020:
>>> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
>> 
>> Although a little late to the party, I've managed to throw together
>> enough firmware to describe the MPAM hardware and take this set (more
>> specifically mpam/snapshot/v6.18-rc4-v5 branch from James' repository)
>> for a spin. Using the branch, the kernel is able to probe the hardware
>> and discover the advertised features. Yay! We are in business.
>
> Thanks for giving it a go. :)
>
>> 
>> Having said that, there are a few quirks of the platform that run into
>> issues with later patches in the branch. The platform has MSCs attached
>> to shared L2 caches which are being skipped during later stages of
>> initialisation. IIUC, the L2 MSCs' limitations stems from the
>> assumptions in the resctrl interface.
>
> What in particualar is being skipped?

The registration of the discovered MSCs with resctrl and subsequent
exposing it to the user.

>> I was wondering if there are any patches available to relax these
>> limitations? I can give them a try. Or do these need to be put together
>> from the ground up? Any pointers greatly appreciated.
>
> There are some extra things added in the extras branch [1] e.g. cache
> maximum usage controls (cmax). However, lots of possible things are
> still missing e.g. any monitors on L2. If it doesn't fit with the
> topology expected by resctrl then it is unlikely to have been considered
> yet.

Thanks for the pointer. I'll give the snapshot+extras branch[1] a try.

The platform does have both controls and monitors attached to L2. If
this isn't being looked at, I can try and put something together. Thanks
for confirming that the limitation is likely due to resctrl.

Looking forward to the next set of MPAM support landing.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot%2bextras/v6.18-rc1

[...]


