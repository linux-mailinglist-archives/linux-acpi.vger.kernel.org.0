Return-Path: <linux-acpi+bounces-19494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7ECADEF4
	for <lists+linux-acpi@lfdr.de>; Mon, 08 Dec 2025 18:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31C3304EB54
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Dec 2025 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFAE2248AE;
	Mon,  8 Dec 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFKXqrSh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OWmorjt9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AC2C86D
	for <linux-acpi@vger.kernel.org>; Mon,  8 Dec 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765215842; cv=none; b=XUnOxpAVJ0qOZg325t1PAtn1TDmZBSnQIsowFtB/yRlQltl1jvCbTo/LkJfoMqLRFk4HjhTcXHBL5J6A1jSoPd1mvERXhWrnixOzXTkWTa7YDz/x0SAf8Kd374Suwhh2ZeEYbuL/vwQp5t7e14eVc6tgtTGh8LStj5t67C9e/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765215842; c=relaxed/simple;
	bh=Dy+uGCjL9abzPlPXpCZt0Qu6zEDLMZkso9CbrRevnjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GThjK2gBXW1TdggfFF/VahM/GRqOqDAFubX841EKp39R5NV1f7IDG+R4uzlhboJNOayHsbPfs4I+r3pkf/rncKR0TeesvpUVH5d2UabmGIWSZXB0tV0t3tsHlGYV6qKECWZeG14Xga89kKTv0Ir+SsTXDirk2ZzSfqAEy4D7wwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eFKXqrSh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OWmorjt9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8B49881130485
	for <linux-acpi@vger.kernel.org>; Mon, 8 Dec 2025 17:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Q6fsgzWvi3sSol9zv39CnVVS
	OO0xtUX3H0IOMdGV9U0=; b=eFKXqrShGzYLgUxfn43zZmkBUyxv1RTpPUnqG2Gp
	OOgEG7OmQJFJft00MGUVjziDZDs3J9Tdh9zPf4OQ4sLJwyT3bVHqte46+QrovYw7
	IaCtXqw/c0sZiAehvOVeHFKNZrJ0PKaFigDOkJJBj1bVGld73f1BMS+b8TBny4dV
	RqvmCF+UQu8hn1byEukik8MD4N23eCz6ioZmpgsRvTk057nn0gzmRUB6eXk7CxCm
	C2FGXODZ2XrNJHHYWvCkd743zlTB2g4oV5erMrwCff4omOp61uMmwSS9ribQhgbG
	ZQ88NE6VujtnS7CuTQFZLnpcPXPhwrwlPkuv5W77kd3GZA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awwfr96b8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Dec 2025 17:44:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88041f9e686so122706586d6.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 Dec 2025 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765215839; x=1765820639; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6fsgzWvi3sSol9zv39CnVVSOO0xtUX3H0IOMdGV9U0=;
        b=OWmorjt9JqkJsscWApNfHJwZfzi6tJwWYWsjdnv0RDY0bAAL6byFT13Byy2FZogP8c
         Qh0STM693InDf06/REqMfKtrs0mh07HPSVuupbbXa9JfmyRehVDt4ZV+aZme6fLxYtTo
         +g8inzJ+VGUOYCRQvza4CX8AOz8zZ5qVAQ8j7ahvP3p08vMSiT1vsud/wWg/497dfVDG
         Ts/hbjn0L69whuvLJHFtTcLsXR0HJLNEnvzmjr6NlFbj1qReYr1X2XBABxj+0aK1v6qj
         xdjrarMCcnAWZ6wRwc0RR5ZcAO4/fEHNdXNb7m93mAglslBYpjwc16KOg5eEDqN9Y3+T
         eWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765215839; x=1765820639;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q6fsgzWvi3sSol9zv39CnVVSOO0xtUX3H0IOMdGV9U0=;
        b=sW/TgefpM9ScG1U8sAJ6pj7Gt/kY9pOi7e1LydhTQWGjgya5KjjC2mDEPE3UDHEU0K
         D/omKpuKe0SDCLfETRIoNI0uLw6foZHc4Th7e+B8ZvGgu2MUlTcim+0TrVpxHp4QAaeR
         Haoh4GnV1fyfXOVpnae+jYI5A1KIIx/uhD4tpke2Jos7nzl4Ud+R5FZ3/dH9UHiT2Huz
         ICxNaSh2TduTgAyoOSJfNFZ0NGco9sxjDrKqhWh2MeWMUhAwNWm+eGzgbbzdAcnb+Ssm
         6wDlAXR+2iiolKXxU9aU5G6fRuBAfhPBsuq0Ja7Ym9EdR62Cp0P3i55kdLwiO9w2557U
         b83A==
X-Forwarded-Encrypted: i=1; AJvYcCVy+QDSKR8H5U7dUqWCAUN7J7vlUE1G2CpsdWb4p3ysc+m+3GEHaMX+z1Skx02y96NMroWlT5kqJb1/@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZRaeNF4nPyh4uOa45tiQaNWRnyuRwjo8BJXEHdFaPohG2CxK
	Hox9z731SHvLLujdK07cCdwK1kggXYxjg1K/Rc97SYm79z8StARc4b1JFD8lFdRL6nHRYUyUTEY
	Rq8QgTd4MLUofjg3cVKkA/LMSOOV39FNAV9jSmeIligyM2Dl2JHkPoIR+08+MIbz+
X-Gm-Gg: ASbGncteyzFdAxhdhCLE1Xx/JgM7hub6KBlHcAkgjQdd33XOkm/ynOooyDy1xA6OQmj
	E8GTS1Ir6qdNpXXwcpt6RNYLcwYOlDlb+qWCUkUUowLI3aGoZv1x9NwqJ3S8oeVD67NA0WT8h46
	SjQ8HbZnpuX/fM6seNe8NFmABS4+uhUDcbV4kAdwhcMuv0rrV5uFz7F6x15Q+4Bz/e8TyHc6RyI
	4lITq4UZ4Xi9FEg9NExZxB943JELqKasPzWDR/YurYSWtsPJ8JeXPIU2MUKs30p7GLa6abaM0AJ
	AUluziF27niKTeU3a/doNLIl1ltkDfFw/LQlT5+QmsRQgs43ArRHeV3fpQvnYKHYHdNtr1Oi6wT
	q3S4sDdK7f1wLvtlxxdvPZW5D
X-Received: by 2002:ac8:7f07:0:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4f03fed422cmr138185521cf.40.1765215839327;
        Mon, 08 Dec 2025 09:43:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9OyOAi9BuO9c+IMpTeXVDBTWFpo10m/j3UtPXRgq17iETikhHSoyjng2VKoKeziJ3cERLXA==
X-Received: by 2002:ac8:7f07:0:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4f03fed422cmr138185161cf.40.1765215838909;
        Mon, 08 Dec 2025 09:43:58 -0800 (PST)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479308cd87csm269816035e9.0.2025.12.08.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 09:43:58 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Punit Agrawal <punit.agrawal@oss.qualcomm.com>,
        James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
        <baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
        <carl@os.amperecomputing.com>, <catalin.marinas@arm.com>,
        <dakr@kernel.org>, <dave.martin@arm.com>, <david@redhat.com>,
        <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
        <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
        <guohanjun@huawei.com>, <jeremy.linton@arm.com>,
        <jonathan.cameron@huawei.com>, <kobak@nvidia.com>,
        <lcherian@marvell.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <peternewman@google.com>, <quic_jiles@quicinc.com>,
        <rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
        <scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
        <sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
        <xhao@linux.alibaba.com>
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
In-Reply-To: <5261337c-337d-44ca-aff1-0a927b81e593@intel.com> (Reinette
	Chatre's message of "Fri, 5 Dec 2025 11:11:34 -0800")
References: <20251119122305.302149-1-ben.horgan@arm.com>
	<877bvfa23i.fsf@stealth>
	<a04aa337-a3eb-42a0-855b-500ba549e2d8@arm.com>
	<87sedrlsjk.fsf@stealth>
	<642767c9-f926-490a-83a1-160978c37553@arm.com>
	<871pl9krdz.fsf@stealth>
	<5261337c-337d-44ca-aff1-0a927b81e593@intel.com>
Date: Mon, 08 Dec 2025 17:43:57 +0000
Message-ID: <87tsy0kgwy.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDE1MCBTYWx0ZWRfX2Qejb0Jlvnwf
 KgURHF8nWHJrFQeDD0cIw860fgSYTdt53hVdT4I7V36+jJNBsP3YmnOB5l15PFaIqp7avSKlstz
 VoeQxAenbLjmXWOgjVKwhWQj9Xt1UwOL3h9LMLOlrjE1FCsJ3st5Fc3pxZ2GMxCRmJZqvungSIK
 dHiWRFqEHfu+ZNkkKNCnu6IKmJRBx4lZDRhvzmEavJ61czU+rwDCqbjjOCHwxtx8tvmqTVAluT8
 k0XQhXS6aIJbn/JCciOv4+1vkhP4IW69jxvSAKWjp8djV7ze4/IaJlxJeO0ZcxVQ8hj4xWrKc6e
 5dMaSsAx/RYHuLlY9+ECteXHeeUuIxnlGuu5U6Z/Pr+i9QZaicWU0ogj671eZv4paBa8nHdgr4z
 W39H3SbPdOz5TslX/nq3AfNpMjJh3w==
X-Proofpoint-ORIG-GUID: DdU7GQsUdZBUFhFVD3aw2ocK8hu-K_Iw
X-Proofpoint-GUID: DdU7GQsUdZBUFhFVD3aw2ocK8hu-K_Iw
X-Authority-Analysis: v=2.4 cv=fsXRpV4f c=1 sm=1 tr=0 ts=69370e60 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=QyXUC8HyAAAA:8 a=SgM2RwbWsAO8Gts_S_MA:9 a=1HOtulTD9v-eNWfpl4qZ:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080150

Hi Reinette,

Reinette Chatre <reinette.chatre@intel.com> writes:

> Hi Punit,
>
> On 12/5/25 5:08 AM, Punit Agrawal wrote:
>> James Morse <james.morse@arm.com> writes:
>>> On 03/12/2025 11:21, Punit Agrawal wrote:
>>>> Ben Horgan <ben.horgan@arm.com> writes:
>>>>> On 11/24/25 15:21, Punit Agrawal wrote:
>
>>>>>> The platform has MSCs attached
>>>>>> to shared L2 caches which are being skipped during later stages of
>>>>>> initialisation. IIUC, the L2 MSCs' limitations stems from the
>>>>>> assumptions in the resctrl interface.
>>>>>
>>>>> What in particualar is being skipped?
>>>
>>>> The registration of the discovered MSCs with resctrl and subsequent
>>>> exposing it to the user.
>>>
>>> resctrl's 'L2' support is limited to the CPOR bitmap.
>>> If you have controls, there is no resctrl 'event' that can exposed them.
>>> (the problem being they all have 'L3' in the name!)
>> 
>>>>>> I was wondering if there are any patches available to relax these
>>>>>> limitations?
>> 
>>> Knowing which property it is will help - but some of these things are checked
>>> to match resctrl's ABI. They can't necessarily be relaxed without breaking
>>> user-space.
>> 
>> This platform has portion, capacity and priority partitioning, as well
>> as memory bandwidth and cache storage monitoring. The MPAM code seems to
>> correctly parse the properties.
>> 
>> But as you point out, the resctrl 'L2' support doesn't have anything
>> other than CPOR bitmap yet. Have you looked at what's needed to extend
>> resctrl to support some of the others?
>
> Please see [1] for a summary of ideas on how resctrl can support multiple
> controls. Nothing is final, please do add your ideas and requirements.
>
> There are a couple of opens not included in the summary. If interested
> [2] is where a lot of discussion happened that prompted the need for
> a summary.

Thanks a lot for the pointers.

Let me catch up with what's already discussed and raise any points that
are not clear / need refining.

>
> Reinette
>
> [1] https://lore.kernel.org/lkml/aPtfMFfLV1l%2FRB0L@e133380.arm.com/
> [2] https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/

