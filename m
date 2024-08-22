Return-Path: <linux-acpi+bounces-7771-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8833295AF8C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0FC1C2158C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AE11537A3;
	Thu, 22 Aug 2024 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b="RSnIQpqo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C733EA;
	Thu, 22 Aug 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312691; cv=pass; b=rTLZGpYod8Wc1RiFfezCGLMeklPxKJY9EPGWu5BVCrIhldJeisufoCtNxZx3dw5B9puVp7KOgcmehwB5WsK9vPrvCPzexADS2Cw0EqLmCcNdgjzVBTWu3hrW+Vo/5BtAPdZf5kVZgaxXUu2bCQjMv12dheXjFuo0SHnOuymqrCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312691; c=relaxed/simple;
	bh=QQX7qVvu1f0rNGg1/gNTbaFdvzC6hFPchOm00EiJzZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qdmngrq47rgA9FxYD/JD9HhlYZDbvQupEYwWyHgOotB8tfVEGcG8+Ds0CJNd/jFYLTOdI8IRqWdxsBZzWH03VPtQ3r6FKU1446ci1bXn5jYszQsNUzfsn3mKkiFUJJSGO+HBczXkWuTDYXk2ZcnjVwGtUd/IunIAKPvr1I73ARs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz; spf=pass smtp.mailfrom=jevklidu.cz; dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b=RSnIQpqo; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jevklidu.cz
ARC-Seal: i=1; a=rsa-sha256; t=1724312671; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B0wnUG3UHEcTRfbjC9HSfLJG+WBnpU18yag7r0240QuMQMnP/cHcj9e4oJU2FgxRPLpt6OGnlZOiPNE2GUFgnkBzKBPwzxb7eTHFwW4P8cW+1IrIOQ6jZWd2rhOIyWcRKYMydfCbMPM04Z+RwKVyRlrLTYL5UDBYYKKHOG08Ikc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724312671; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y3v3IIFARTszfLWu7n/j8Du29EOi4VTxMDP3GF4qp7E=; 
	b=VvZAc/xKVy85rZpNNCAwUwpxquk4r4Xw2QjZmePGlnINwOvJf6oilR9lqx2WDMezV20iKTW9f3dauO4jIjp363HOdh7P21UFfa66a0oK63RODo7IQMHSCqaCwAEoO1PKHfDfTMwz0/BShU1dt+nhtAeSeKwbG7G1qizCcoXTdjo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=jevklidu.cz;
	spf=pass  smtp.mailfrom=petr@jevklidu.cz;
	dmarc=pass header.from=<petr@jevklidu.cz>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724312671;
	s=zoho; d=jevklidu.cz; i=petr@jevklidu.cz;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=y3v3IIFARTszfLWu7n/j8Du29EOi4VTxMDP3GF4qp7E=;
	b=RSnIQpqoQp2O3ExJNnw4fk9dlt8CX1T5sbtB6GflBDYejiRQJTcrU3zRHn3pRkFq
	tm00/cgXr6pF6T5vJFttBkfrHtnRiPiE8cjqni5KsNxCyOXOwri6I5ARAmPcUj42eda
	e/xHQX9E3ayXrWSBQDAsun3Ann63tcXQKwlT7ffI=
Received: by mx.zohomail.com with SMTPS id 1724312669862808.3168476405893;
	Thu, 22 Aug 2024 00:44:29 -0700 (PDT)
Message-ID: <5ba3c7c2-5695-421d-a747-2a23af48db26@jevklidu.cz>
Date: Thu, 22 Aug 2024 09:44:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI IRQ storm with 6.10
To: Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Hui Wang <hui.wang@canonical.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240821145959.GA248604@bhelgaas>
 <1041b9b5-cc78-13b1-459a-d1d3a313475a@intel.com>
Content-Language: cs-CZ, en-US
From: Petr Valenta <petr@jevklidu.cz>
In-Reply-To: <1041b9b5-cc78-13b1-459a-d1d3a313475a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



Dne 21. 08. 24 v 17:17 Vitaly Lifshits napsal(a):
> 
> On 8/21/2024 5:59 PM, Bjorn Helgaas wrote:
>> [+to Dima, Vitaly, Hui; beginning of thread at
>> https://lore.kernel.org/r/60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org]
>>
>> On Wed, Aug 21, 2024 at 01:39:11PM +0200, Petr Valenta wrote:
>>> Dne 20. 08. 24 v 23:30 Bjorn Helgaas napsal(a):
>>>> On Tue, Aug 20, 2024 at 11:13:54PM +0200, Petr Valenta wrote:
>>>>> Dne 20. 08. 24 v 20:09 Bjorn Helgaas napsal(a):
>>>>>> On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
>>>>>>> On 19. 08. 24, 6:50, Jiri Slaby wrote:
>>>>>>>> CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to b2c289415b2b)
>>> ...
>>>> I'm at a loss.  You could try reverting the entire b2c289415b2b commit
>>>> (patch for that is below).
>>> This patch didn't help, so I reverted it back.
>>>
>>>> If that doesn't help, I guess you could try reverting the other
>>>> commits Jiri mentioned:
>>>>
>>>>     76a0a3f9cc2f e1000e: fix force smbus during suspend flow
>>>>     c93a6f62cb1b e1000e: Fix S0ix residency on corporate systems
>>>>     bfd546a552e1 e1000e: move force SMBUS near the end of enable_ulp function
>>>>     6918107e2540 net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates
>>>>     1eb2cded45b3 net: annotate writes on dev->mtu from ndo_change_mtu()
>>>>     b2c289415b2b e1000e: Remove redundant runtime resume for ethtool_ops
>>>>     75a3f93b5383 net: intel: implement modern PM ops declarations
>>>>
>>>> If you do this, I would revert 76a0a3f9cc2f, test, then revert
>>>> c93a6f62cb1b in addition, test, then revert bfd546a552e1 in addition,
>>>> etc.
>>> I have created revert patches like this:
>>> git format-patch --stdout -1 76a0a3f9cc2f | interdiff -q /dev/stdin \
>>> /dev/null > revert_76a0a3f9cc2f.patch
>>>
>>> I have applied revert_76a0a3f9cc2f.patch (rebuild and tested), then in
>>> addition revert_c93a6f62cb1b.patch and after applying
>>> revert_bfd546a552e1.patch irq storm didn't appear.
>>>
>>> I have tested it with 3 subsequent reboots and in all those cases it was ok.
>> Thanks for all this testing.  It sounds like reverting all three of
>> 76a0a3f9cc2f, c93a6f62cb1b, and bfd546a552e1 fixed the IRQ storm, but
>> I'm not clear on the results of other situations.
>>
>> It looks like c93a6f62cb1b could be reverted by itself because it's
>> unrelated to 76a0a3f9cc2f and bfd546a552e1.  I added the authors of
>> all three in case they have any insights.
>>
>> Bjorn
> 
> 
> I doubt that it is related to c93a6f62cb1b, I believe that is more 
> probable to be related to the two other patches.
> 
> Apart from what I suggested in the other mailing thread (enabling e1000e 
> debug and to test if it happens with a cable connected),
> 
> I suggest to try to apply this patch and see if it fixes the issue:
> 
> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240806132348.880744-1-vitaly.lifshits@intel.com/

I have applied patch from link above and command bellow really doesn't 
start irq storm.

echo 'auto' > /sys/bus/pci/devices/0000:00:1f.6/power/control

Problem is that after executing this command and plugging cable to 
ethernet port, kernel is not able to detect link (LED indicate link is 
on) so network over cable is not working.

> 
> 

