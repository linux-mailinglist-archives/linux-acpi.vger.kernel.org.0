Return-Path: <linux-acpi+bounces-19212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCED5C8155B
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 16:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B2D5347116
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22933313E00;
	Mon, 24 Nov 2025 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cyiy0pY5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LvfBeTAu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DAF30AAC1
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997671; cv=none; b=qNQthLlP5FdRicvVWs74nmBfBEKHkAR3KQwe2pLIc09wDfwJGBl1vBY8gzNcF8JeOKiikmCKCLxHdyUMTMHeO1MzCPXOtz5nGatXbcdQImDb8H495apjhmfa1qHRND3OuwAjQfn+FJKLw5S2ONEnYedYW/QZXeNRt9omFRCugAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997671; c=relaxed/simple;
	bh=BsdAQLGpRLJSdHZqTd1Sjbh6N1hN90ov2SRgLAfMpPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N7moYAHMJgWH6xEnb6GBtaQWnsp2mgi+JKEhV/joHkDMXD1A3wuUelJbcLC/LjNJ/I6cIKoWAerxiCbgaIIByzzgR9xJc8els5bi6MsGowuLs15cVMudcQl+IQ0qDJdilUiJrlxfrH9BIPgSI+DMtoH8EqbbMsMYmPoKV6KWxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cyiy0pY5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LvfBeTAu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO81m2N1688024
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 15:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7Xp5hyyL92DGXPcsi62gt/ZC
	nMgydkx2tDNxw9WvsLg=; b=cyiy0pY5tq3c1wYdYzJOePxX6Pn4Do4Xu7ovIMjm
	y+ERWtY5iZXG1Q74vA+LYw/vWGbs7nXq1Rl8exwK/TdGFVac1l+lWNcPsHCdVw8Q
	jqiWbzO124WbyPLndoNDD6zBVy8YkTX+scynTB9HzSaq4IH0/x0v6eOEpTNQ7OWp
	peThRHbSGlYGzn3vIGa54OfkhZ/v39Vnpo8R6KtzIDRmG8qkhoS7dE3hRItaCtxs
	VpOYVrw0w2SM/nrA7sv12svu7/2AYABD2HUGeuvsgMysAAs7TTdP2dlkqrjSXpVn
	PSLpiWU5uj0CVOFc53Z5Hy5Agm+2cwxucOe9NAQEFMy8KQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ama09aeq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 15:21:08 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dfaab3a44dso8675886137.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 07:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763997667; x=1764602467; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xp5hyyL92DGXPcsi62gt/ZCnMgydkx2tDNxw9WvsLg=;
        b=LvfBeTAuZhCRC0nuCRvXRwq40Bbrvr0zqZG9cA3cAHAmgeN9czioVHU4QHgTIBcJpJ
         SvYNc70Hg44zzhvY6QpqwxDeFQ33/1Bt1oGpuIy+VP9kk/dQ2O70FinglXeibiTiJOkz
         UzBCD4oLkktYbfYnvTYM007fFar7jSvZvRFocieGLkCwiJjmzlFuDDwYj7cjxjGRShBi
         Efbq9AEzxmKXuKP3FC88Xx0b/8gg56FGZ2GYPXuflBlaQASnNNSJNUWFtOqjnIOCGl5f
         YoDHks2sR1f/2brXs7xbV5DPTSJ/KJAY5Iy0wU6nhFLVaQ330gNkCHNMQW+MleaCOMDL
         q1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763997667; x=1764602467;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Xp5hyyL92DGXPcsi62gt/ZCnMgydkx2tDNxw9WvsLg=;
        b=ZQCVgF2ZIiWhYI4QXEPzfZunAAmTa47o+p5935n7rGds8CEYVlV+qstwDFMm8eyHmt
         7WO8eASPElQCXQz1NI04UIJ+OW4ayJPaP0vQ89odWXusp58RW1lNPM4GRnyT/qzaSX8L
         CtZypUQEtAnrs7G2dWafDHqseFaY2PmaktGhBRObGOALWkLcVHt2Nhyd5/GLzlxqEJq9
         Zj45eBCNmjfhrbGH2UzZd5a6SdsDGehqCAufPfFV5/p3GL8QSziFvW6EzokCqc8o8b+N
         x3K8j2YboNfsxNiqxTzEDBbVvgvxdjI9DZejhgmluQvKSI+RUF7ke30c0xofJ4GrIy9R
         5/BA==
X-Forwarded-Encrypted: i=1; AJvYcCWGRh8b+szFGiX7IK1KLWz+TsiYc4mcL0LCVE6i8XeNl55ev/qzTDiwdYsu2fKP99mrDVYO1jy3vzIj@vger.kernel.org
X-Gm-Message-State: AOJu0YyLunp3tFKzJ/DN7BugKzBXkkjCFEZ3UImYYSWH7WlXqrJirbUe
	YCVRYN+hJHnktGFNDY71Jr0hurotD0E3I55Vl7E79pW0YeqMWVA7HBEbpDuluABCToDUFVZfMTV
	S6uDUTnEtGneWSOwxWphEYShRtYR6KwtmKNit+nUiIL7xAMDXsSWVi+25VH5Qpfn8
X-Gm-Gg: ASbGncuLQjrTeTsipz19mlAcxP8EBB1ovu7kWs4gZG+Pj6ddlHaiwPnxrsPDRmR6x5T
	t00Kh+MxNxN+PDonZcS61xsiwEitD5jHI4SWz7cuBzeiJBmyl+/7b0pfq3Fa2UaTOgM3KIGftRb
	+nQSGDvKHah06KCDdScD5XHDaTmFUdbX1j1Hpzkf2rcVB/ZKdYeXZOuNCu9+18jvwpYGEAvlmvV
	4ZKFJYaEyuM+lPpb+hdtoEVlRwlSv6pCcuEt3V2rbhjyqPojhfQ3kfdYLJzmTCbwsvYcmqGPcpz
	w5OBkqKtM9wZGiiQ1fwVrngn7WgmHI0FJL35IA+XQH1HnVaT6iZ7usvopp8gkF8ILbH01yKrMoO
	KHSntmkHA9Uh4n6tdhjTlDsiW
X-Received: by 2002:a67:e7ca:0:b0:5db:db1d:e1cc with SMTP id ada2fe7eead31-5e1de3add6bmr3993499137.23.1763997667175;
        Mon, 24 Nov 2025 07:21:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwLbgq+f0syhYUIH8yRhYl+rqLz6oua3c3D1yhqylImpHoqxcKHLhjT0WLSt++6fQeJ9uiEQ==
X-Received: by 2002:a67:e7ca:0:b0:5db:db1d:e1cc with SMTP id ada2fe7eead31-5e1de3add6bmr3993454137.23.1763997666665;
        Mon, 24 Nov 2025 07:21:06 -0800 (PST)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf226c2asm199781335e9.10.2025.11.24.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:21:06 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
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
In-Reply-To: <20251119122305.302149-1-ben.horgan@arm.com> (Ben Horgan's
	message of "Wed, 19 Nov 2025 12:22:30 +0000")
References: <20251119122305.302149-1-ben.horgan@arm.com>
Date: Mon, 24 Nov 2025 15:21:05 +0000
Message-ID: <877bvfa23i.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uE7CuR7VPfGIJ6FsO0q1m2BD5apMNyjS
X-Authority-Analysis: v=2.4 cv=PdHyRyhd c=1 sm=1 tr=0 ts=692477e4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
 a=kNSAGAUgJmWAU3osOT0A:9 a=ODZdjJIeia2B_SHc_B0f:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzNCBTYWx0ZWRfX0VSXCbmjSTzo
 fzrbFemff1zv1OeNokmi7K/CU0Qae9Nt7RTVCNEA4uR6tgOWn0T6wUSs2x+5u806h3ehWqx9q20
 MRikOez7sb1XQh7f50oYMmzWKxBDhJQMHTubpz3L22zTft9SjFfSL7YADkacC2vRMIz54XE/+N+
 Y6cI9H2Q3N+gC38Zn1YCrhL+utwpeLDmW1Do0barTSba7iRNdpaUTI5gvUxGkFMsLdaNv8oI0Ch
 oddRIkXjijWTFAyBzCbvQ+mDv8Tq4XWcz0iY/qtN2fjE72RorFl8PsNkUieY4y9SvzLbEdEHGfD
 Rai6lF+vf9vyICJnozksPtCLzL0HFvWvmkGTxt/lc6dF+bfriU3OOUo6yIdEgDjfPNwdUxyD2sP
 NMxcyqSM/fGk7A9kFVjJpyXuyzBQVA==
X-Proofpoint-GUID: uE7CuR7VPfGIJ6FsO0q1m2BD5apMNyjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240134

Hi Ben, James

Ben Horgan <ben.horgan@arm.com> writes:

> Hi all,
>
> Just a handful of minor changes based on v5 review comments. See individual
> patches for change lgos. I haven't asked James to host any branches for this
> revision but please let me know if this would be helpful to anyone. Thanks for
> all the help with reviews and testing.
>
> Previous cover letter from James:
>
> This is just enough MPAM driver for ACPI. DT got ripped out. If you need DT
> support - please share your DTS so the DT folk know the binding is what is
> needed.
> This doesn't contain any of the resctrl code, meaning you can't actually drive it
> from user-space yet. Because of that, its hidden behind CONFIG_EXPERT.
> This will change once the user interface is connected up.
>
> This is the initial group of patches that allows the resctrl code to be built
> on top. Including that will increase the number of trees that may need to
> coordinate, so breaking it up make sense.
>
> The locking got simplified, but is still strange - this is because of the 'mpam-fb'
> firmware interface specification that is still alpha. That thing needs to wait for
> an interrupt after every system register write, which significantly impacts the
> driver. Some features just won't work, e.g. reading the monitor registers via
> perf.
>
> I've not found a platform that can test all the behaviours around the monitors,
> so this is where I'd expect the most bugs.
>
> The MPAM spec that describes all the system and MMIO registers can be found here:
> https://developer.arm.com/documentation/ddi0598/db/?lang=en
> (Ignored the 'RETIRED' warning - that is just arm moving the documentation around.
>  This document has the best overview)
>
> The expectation is this will go via the arm64 tree.
>
> This series is based on v6.18-rc4, and can be retrieved from: (no v6 version)
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v5
>
> The rest of the driver can be found here: (no v6 version)
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc4-v5
>
> What is MPAM? Set your time-machine to 2020:
> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

Although a little late to the party, I've managed to throw together
enough firmware to describe the MPAM hardware and take this set (more
specifically mpam/snapshot/v6.18-rc4-v5 branch from James' repository)
for a spin. Using the branch, the kernel is able to probe the hardware
and discover the advertised features. Yay! We are in business.

Having said that, there are a few quirks of the platform that run into
issues with later patches in the branch. The platform has MSCs attached
to shared L2 caches which are being skipped during later stages of
initialisation. IIUC, the L2 MSCs' limitations stems from the
assumptions in the resctrl interface.

I was wondering if there are any patches available to relax these
limitations? I can give them a try. Or do these need to be put together
from the ground up? Any pointers greatly appreciated.

Thanks,
Punit

[...]


