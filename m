Return-Path: <linux-acpi+bounces-21488-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GI0MorNqmkNXQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21488-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:50:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 101BD220F87
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1718319485F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D329B8D9;
	Fri,  6 Mar 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8tp9lUU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76828C864
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800980; cv=none; b=R1KX51425F3maPXEubhECjYWzq18DBg60smVrnVN7vTfeZprKiOBD0vK9NRJOm9F5XdRJjxwgIKYcITDg+z1q4TtgPZSomJAGPXc/U1H8Y2/bQQaP8gDN8MPskQPNPj9cu0SK6fwbOpeDbNeU9JfRBUxMjBE5tZrSUEjw0chvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800980; c=relaxed/simple;
	bh=gSmTssy6CNAAgTZVKgwAcfCJxvMXUcM2Ff7OKTcAWos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l363yODH8X8wtPVhb6b8fPD5a/ER+ElN3GuLT0zqdosGDQyGVPwrOXVZDWgZ1tbkAeuH5bY2v4+u0uEm3l14plqScCetPF2H8bjbf+JAhYnDJWOugW6YonTNKlWriF6bcLF1P45k/ArhJ9Uzqm3B/yBGqTsFywKgTzzD84ZOs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8tp9lUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E647DC4CEF7;
	Fri,  6 Mar 2026 12:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800980;
	bh=gSmTssy6CNAAgTZVKgwAcfCJxvMXUcM2Ff7OKTcAWos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l8tp9lUU8gK29/LPrmM/X3xbs/Q/kG0p9AkRk6597v/jWPh9DFc6jtRJbN3RKvvXv
	 qOFN4G+rOzpLisfr6HzzhwNIJL+dwKGf11RDCFLBKmDepUXRM8+1Pwrh7Ga1vamaoW
	 gYaIrlz3XhxIdMSSGS+WSycxKTLiEdMJ16PgGFTI2yiPbIBJYAWJJNi9U0f7r4HQ5t
	 1OsZkjR7SzIOgqijY/2DLLnUq3QY5dBMFGaZWZnKdmDXdNTphpLDGHFL1tPlLABrRE
	 eY+5zO5Jp1qgAYMf5rD3+/QEgQOzDCrJAHT2TABqvCeVwRHM5i7RukypKsZJv3LNUU
	 pQ2IS1pbNs0Pg==
Message-ID: <23a0f5f8-11a6-4f41-9e32-19cb08110bc6@kernel.org>
Date: Fri, 6 Mar 2026 06:42:58 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Don't allow MFD devices to probe
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, W_Armin@gmx.de,
 Pratap Nirujogi <pnirujog@amd.com>, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org
References: <20260306025144.604062-1-superm1@kernel.org>
 <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
 <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 101BD220F87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21488-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmx.de,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action



On 3/6/26 6:17 AM, Rafael J. Wysocki wrote:
> On Fri, Mar 6, 2026 at 11:50 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Mar 6, 2026 at 3:51 AM Mario Limonciello (AMD)
>> <superm1@kernel.org> wrote:
>>>
>>> After ACPI video was converted into a platform device in
>>> commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
>>> other devices that are MFD children of LNXVIDEO are being probed.
>>> This isn't intended.
>>>
>>> During probe detect MFD cells and reject them.
>>>
>>> Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
>>> Reported-by: Pratap Nirujogi <pnirujog@amd.com>
>>> Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c794c5952018@amd.com/
>>
>> The link is broken, so I can't see what is really happening, but my
>> guess is that MFD devices are created under the video bus device and
>> they get the same device ID (confusingly enough).

Hmm, I just double checked the link and it worked for me.

But you are on the To: list of that thread also.

>>
>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> ---
>>>   drivers/acpi/acpi_video.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>>> index 3fa28f1abca38..2cb526775ac47 100644
>>> --- a/drivers/acpi/acpi_video.c
>>> +++ b/drivers/acpi/acpi_video.c
>>> @@ -14,6 +14,7 @@
>>>   #include <linux/init.h>
>>>   #include <linux/types.h>
>>>   #include <linux/list.h>
>>> +#include <linux/mfd/core.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/input.h>
>>>   #include <linux/backlight.h>
>>> @@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
>>>          int error;
>>>          acpi_status status;
>>>
>>> +       if (mfd_get_cell(pdev))
>>> +               return -ENODEV;
>>
>> If the above is the case, I'd prefer this check
>>
>>          if (!device->pnp.type.backlight)
>>
>> which should also work, but is more general.
> 
> Well, this will not work if the ACPI companion is shared between
> multiple devices.
> 
> However, adding an MFD check here is a "works for me" change rather.
> 
> I think what needs to be done is to extend the duplication check (see
> my patch from yesterday at
> https://lore.kernel.org/linux-acpi/5663583.Sb9uPGUboI@rafael.j.wysocki/)
> to detect the cases when another platform device (not necessarily a
> child of the same parent) sharing the same ACPI companion is probed.
> 

Generally makes sense to me.  But in this particular case it shouldn't 
be a FW_BUG.

Do you want to roll this in your series?  Or would you prefer one of us 
to send a follow up patch?


