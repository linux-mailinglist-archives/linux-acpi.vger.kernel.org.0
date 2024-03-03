Return-Path: <linux-acpi+bounces-4069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4AB86F398
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Mar 2024 05:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960E8283963
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Mar 2024 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643AD613C;
	Sun,  3 Mar 2024 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uxBPuQ5q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD15CBD;
	Sun,  3 Mar 2024 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709439211; cv=none; b=up+b0w4/KKyQ/OaB4oN5Dm6OafWJhoReymxd+Ursq3xSQuaWkWbGxUejyPQjzK350marYrG4pqTdt5mzhWCwEPOM9rabZuzYq705y23+by3yOMJgKUoBBTxhhYVRT6M/53GFxquKWdXFNchBF9uI8pksNdftipGYaIcplwr+Ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709439211; c=relaxed/simple;
	bh=lWck3gpoBtZI8TsKjUM0R4WTZBziWp/6sRRUfbwiTYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Inm3P0Ime/y7x+d9nrEkloIfUstZUDW/wL/YXSWOhDY5FMVozN85tLLyqSXGyRt9iIL+fJ7AzyeyUCSgyDIDTCq6gB/UOJK5f4bj+zYpzg/Hzi0W+Ki5Yc05xFVR4ZhGEGZHvH7RRxQXjVwM+F8m5u43zPmrZeMsIWWMdbr0Q5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uxBPuQ5q; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709439199; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n0bhjhSdOpGkg5nl83a1b4VGcBmv7bJsCtYK9kEKfW0=;
	b=uxBPuQ5qf+/RorBOhl8Ih8/cHIknhvSvoLqMnkiK5quKo/Ghf44ebQoKx1q1Izcz0lRxPypSbpLdhfD1HqXHzKPA0AL+Ek+yZFWgHXEIYWJEUBHt4funUWFazW6SoTmBnwsY3BaR2MAJ8vMYjjpbZ7vp7X1Afg9ohTIe9JrZPNc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=herongguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1frd-k_1709439198;
Received: from 192.168.0.111(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0W1frd-k_1709439198)
          by smtp.aliyun-inc.com;
          Sun, 03 Mar 2024 12:13:19 +0800
Message-ID: <2e00db1e-a9fc-4efb-b95b-b216125e105f@linux.alibaba.com>
Date: Sun, 3 Mar 2024 12:13:18 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cstate: fix mwait hint target cstate calc
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: jacob.jun.pan@linux.intel.com, lenb@kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, shannon.zhao@linux.alibaba.com
References: <64137e23-e374-4129-8e3c-dcd7606364d4@linux.alibaba.com>
 <CAJZ5v0hG7vpWd9-pdeuNZDpDQ13MuwzgPkFnyG7TuQ=DRAMo6Q@mail.gmail.com>
 <cdb0f30e-b1d5-49ba-8730-740e9c06c87c@linux.alibaba.com>
 <CAJZ5v0gqcN7F+xzXPdOnYV5m7Lvoa2q8Pftv6u0=_VVA6-FrHw@mail.gmail.com>
From: He Rongguang <herongguang@linux.alibaba.com>
In-Reply-To: <CAJZ5v0gqcN7F+xzXPdOnYV5m7Lvoa2q8Pftv6u0=_VVA6-FrHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/3/1 19:04, Rafael J. Wysocki 写道:
> On Fri, Mar 1, 2024 at 11:02 AM He Rongguang
> <herongguang@linux.alibaba.com> wrote:
>>
>> 在 2024/3/1 1:22, Rafael J. Wysocki 写道:
>>> On Wed, Feb 28, 2024 at 8:28 AM He Rongguang
>>> <herongguang@linux.alibaba.com> wrote:
>>>>
>>>> According to x86 manual (Intel SDM Vol 2, Table 4-11. MWAIT Hints
>>>> Register (EAX) and AMD manual Vol 3, MWAIT), mwait hint[7:4] adds 1 is
>>>> the corresponding cstate, and 0xF means C0, so fix the handling of
>>>> 0xF -> C0.
>>>>
>>>> Intel: "Value of 0 means C1; 1 means C2 and so on
>>>> Value of 01111B means C0".
>>>>
>>>> AMD: "The processor C-state is EAX[7:4]+1, so to request C0 is to place
>>>> the value F in EAX[7:4] and to request C1 is to place the value 0 in
>>>> EAX[7:4].".
>>>
>>> Yes, 0x0F is defined to correspond to C0.  However, the value in
>>> question is never equal to 0x0F in any of the functions modified by
>>> this patch.
>>>
>>> What's the purpose of the modification, then?
>>>
>>
>> Hi, this is found when I tweak ACPI cstate table qemu presenting to VM.
>>
>> Usually, ACPI cstate table only contains C1+, but nothing prevents ACPI
>> firmware from presenting a cstate (maybe C1+) but using a mwait address
>> C0 (i.e., 0xF in ACPI FFH MWAIT hint address). And if this is the case,
>> Linux erroneously treat this cstate as C16, while actually this should
>> be legal C0 state.
>>
>> As I think ACPI firmware is out of Linux kernel scope, so I think it’s
>> better for Linux kernel to implement here referring to spec, how do you
>> think? :)
> 
> That's fair, but you need to put the above information into the patch
> changelog.  Otherwise it is unclear why you want to make this change.

Ok, will send a V2 patch.


