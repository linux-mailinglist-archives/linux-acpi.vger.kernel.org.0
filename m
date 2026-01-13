Return-Path: <linux-acpi+bounces-20266-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD70D1B7FD
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 22:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BEF730060E7
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 21:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEB3502A4;
	Tue, 13 Jan 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEq/PnhO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA78274B37;
	Tue, 13 Jan 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341514; cv=none; b=IbGMLIojIM1p0mjtb8uT9jLvljBrKcip7+la1/JcTJD6wbMcI3OP4kaq7ibNVYqxLmViXZcjiHAy7Xs3CyIH1gmag1OMGCfXAMQsvyp+Wepm0GkzkNBWLR3+p/8eYb74PJeKDFRRDJrLWwr0UnpGo7QHhRvWGuaHcdNS+n3NxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341514; c=relaxed/simple;
	bh=EhNf0DB6H+D52wFq+xxqhoJVJAJcADLsXCmy5OCFbdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/lT3Fdxk7YjHc1+sokuYjd+OmWeJHdPOcl2Q/CsDDMuFhuncoXgjJxl1D2BdbvYHXEqBzIf/KmJjm1UH1pAFue7+6E29fhrtoUD+r4KpN1O1SNGSi5W6uP4LK+j47+YpzNyIuUz7naAZXEgdXvmUHw7eV/3FJ46mRJOZBzceWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEq/PnhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A54C116C6;
	Tue, 13 Jan 2026 21:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341513;
	bh=EhNf0DB6H+D52wFq+xxqhoJVJAJcADLsXCmy5OCFbdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jEq/PnhOQk0cKOidyojdOU1SLO7t36aR8NukvcVkV68EGokKYxD16lcntgpqeFSz6
	 AlLyq4UIu8v3DzsEEJttS79EYC1naCAkxjkb7//Hx2SdRUAspIm0rLGF9M45Bwjw0Q
	 CHePUK89t44fXhB6Krm9yIAP5muucGeZqK2cgsDXKURI8PPEpHxozFa0sbhSjHDy0f
	 LFXhsOrjZrZFeTMWlFwQOPu5WHPKVdAWGa4KcfJde4wYc7dk6tj6sBcy9sWIOc84uf
	 G7QtKgFEiTV9Zc11cMTwds6lU8VUYY1ssMShI71jmHrzUqRXpAgFflW5+ggKKIcGYj
	 pXpCF7cFMGVjw==
Message-ID: <cfe29b78-93c1-423f-930d-10e4fcda6987@kernel.org>
Date: Tue, 13 Jan 2026 15:58:30 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Armin Wolf <w_armin@gmx.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
References: <2396510.ElGaqSPkdT@rafael.j.wysocki>
 <65c7a296-7dc7-4368-9b2d-6fadd0dbf9c6@kernel.org>
 <CAJZ5v0ihuu_9G7N5UkHAGwRq=BN1spkXmdOuUTxRFwn3acdfbw@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0ihuu_9G7N5UkHAGwRq=BN1spkXmdOuUTxRFwn3acdfbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/7/2026 6:22 AM, Rafael J. Wysocki wrote:
> On Tue, Jan 6, 2026 at 4:47 PM Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>
>>
>> On 1/6/2026 6:27 AM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Sadly, there is quite a bit of technical debt related to the
>>> kernel's ACPI support subsystem and one of the most significant
>>> pieces of it is the existence and use of ACPI drivers represented
>>> by struct acpi_driver objects.
>>>
>>> Those drivers are bound directly to struct acpi_device objects, also
>>> referred to as "ACPI device nodes", representing device objects in the
>>> ACPI namespace defined as:
>>>
>>>    A hierarchical tree structure in OS-controlled memory that contains
>>>    named objects. These objects may be data objects, control method
>>>    objects, bus/device package objects, and so on.
>>>
>>> according to the ACPI specification [1].
>>>
>>> The above definition implies, although rather indirectly, that the
>>> objects in question don't really represent hardware.  They are just
>>> "device package objects" containing some information on the devices
>>> present in the given platform that is known to the platform firmware.
>>>
>>> Although the platform firmware can be the only source of information on
>>> some devices, the information provided by it alone may be insufficient
>>> for device enumeration in general.  If that is the case, binding a
>>> driver directly to a given ACPI device node clearly doesn't make sense.
>>> If the device in question is enumerated through a hardware interface, it
>>> will be represented by a device object matching that interface, like
>>> a struct pci_dev, and the ACPI device node corresponding to it will be
>>> treated as its "ACPI companions" whose role is to amend the "native"
>>> enumeratiom mechanism.
>>>
>>> For the sake of consistency and confusion avoidance, it is better to
>>> treat ACPI device nodes in general as ACPI companions of other device
>>> objects representing hardware.  In some cases though it appeared easier
>>> to take a shortcut and use an ACPI driver binding directly to an ACPI
>>> device node.  Moreover, there were corner cases in which that was the
>>> only choice, but they all have been addressed now.
>>>
>>> In all cases in which an ACPI driver might be used, the ACPI device
>>> node it might bind to is an ACPI companion of another device object
>>> representing a piece of hardware.  It is thus better to use a driver
>>> binding to the latter than to use an ACPI driver and leave the other
>>> device object alone, not just because doing so is more consistent and
>>> less confusing, but also because using ACPI drivers may lead to
>>> potential functional deficiencies, like possible ordering issues
>>> related to power management.
>>>
>>> Unfortunately, there are quite a few ACPI drivers in use and, as a rule,
>>> they bind to ACPI device nodes that are ACPI companions of platform
>>> devices, so in fact they play the role of platform drivers although in
>>> a kind of convoluted way.  An effort has been under way to replace them
>>> with platform drivers, which is relatively straightforward in the vast
>>> majority of cases, but it has not been pursued very aggressively so far,
>>> mostly due to the existence of the corner cases mentioned above.
>>
>> This is the same as Danilo's comment; but could you leave a few examples
>> of conversions that have been done successfully?  Commit hashes that can
>> demonstrate what it actually takes to convert an acpi driver to a
>> platform driver and might make it easier for people to reference when
>> this comes up.
> 
> The purpose of this posting and the new document is to grow awareness
> rather than to tell people how to convert drivers.
> 
> I'll start posting driver conversion patches at one point and the
> motivation for all of them is basically the same, so I thought it
> would be better to document it in on place and then refer to it
> instead of repeating the same information every time a conversion
> patch is posted.

Thanks for explaining.  Makes sense to me.  If you didn't already commit 
feel free to add my tag (no need to spin it if you already did).

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>


