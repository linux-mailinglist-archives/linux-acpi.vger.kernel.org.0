Return-Path: <linux-acpi+bounces-21265-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMoqMUkQo2nk9QQAu9opvQ
	(envelope-from <linux-acpi+bounces-21265-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:56:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F11C42F0
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 379D030FEF4C
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5D47CC89;
	Sat, 28 Feb 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AACHvJVz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930547CC79;
	Sat, 28 Feb 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293173; cv=none; b=BOAfSPwmC3l6QQCSvV0+OPvDy3P4cGe/JERzEXL9fvlebWcpb0EEtCzgEg+RdixYxqwtB6+TPcztj/TWhceXsBnHYYmY68XMMQlA9ZIsrDnPIdWpTcCdqNKF2A+hbPrG48LqsxLsB5ECT6ShGB8jOKO1eLdBpienIxVKfWwf5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293173; c=relaxed/simple;
	bh=vqH8JWH1At3E8561EseqXCazTNcoT1de3KQQuaU8A/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAApDFo18siANlh/MyTHhhwr2GBAb33GBE1nE1TyW7NyHqJCHoqVWYRyEbuy925M9wa+atW6up8/DS7MdGSdliAF9dr8o6dVrgoZ3CPW+1c9IPjg7Uti1q9zV+/YEyolybC8/Nts7sjSDAE9E8QpiD/yYC1oDCiV00r5oJZDEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AACHvJVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA20C116D0;
	Sat, 28 Feb 2026 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772293173;
	bh=vqH8JWH1At3E8561EseqXCazTNcoT1de3KQQuaU8A/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AACHvJVzA+Jga9tGqlfzv658x0+XqTPiW67T0XpVwhiO4YInKYWTW/YtNXW75DSkN
	 abCUMwIKb14QBdevDsIAt+cOWh4mSF4PNoRmkjcI8jcFLUqz8JoAW8/lpovmTjSs04
	 tudQayp45tgDraGMfarJ8Jzciplp0zM4O7w77eLtOiI7FUUSQw7r+7NYJ3VXKG2fIQ
	 gOnco69qooQN0Mt9aooR57PvzdO9n9oTJvKXLjrgnUVd2AMP2iEG/eWzocMHHGls85
	 6ZZoAQRk5MJ6kcCDoMTfo9avZRfVaZuAElN92gJqW2abPGGj9SIgBIHF82kG8s6Ykh
	 0zlP0I9ymeAQA==
Date: Sat, 28 Feb 2026 10:39:31 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Athul Krishna <athul.krishna.kr@protonmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"superm1@kernel.org" <superm1@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Suspend broken on 6.19.4
Message-ID: <aaMMM-97pFFm2C4Z@laps>
References: <aW3d4B3xMwe-pyzJwFnM7q4q5WjOjAajU2c6gk65arrBx5-soWv9AAZPzZHxAiX1XOxILELauRQdnxGxMectmmW76xfxyQyErVEH8nR_iyw=@protonmail.com>
 <CAJZ5v0gL1=m6j5r3ZAp61nmwBb+wd2Y9zPSv=a=NQem5XiZMCg@mail.gmail.com>
 <CAJZ5v0iTJ78cR-Nub7aEvPr=9WDx_DebD0+Co9weYO99oDWTzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iTJ78cR-Nub7aEvPr=9WDx_DebD0+Co9weYO99oDWTzg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21265-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[protonmail.com,linuxfoundation.org,intel.com,kernel.org,alien8.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,alien8.de:email,intel.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE0F11C42F0
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 02:58:54PM +0100, Rafael J. Wysocki wrote:
>On Sat, Feb 28, 2026 at 2:51 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Sat, Feb 28, 2026 at 1:40 PM Athul Krishna
>> <athul.krishna.kr@protonmail.com> wrote:
>> >
>> > Device: Asus Zephyrus G14 (GA402RJ)
>> > CPU: Ryzen 7 6700H
>> > iGPU: Radeon 680M
>> >
>> > Problem: Suspend broken on 6.19.4. On closing the lid or systemctl suspend, screen turns off but device does not fully power down.
>> > No obvious errors in dmesg except:
>> > [  219.151441] amd_pmc AMDI0007:00: Last suspend didn't reach deepest state
>> > [  219.164301] ACPI: EC: interrupt unblocked
>> >
>> > Bisected:
>> > commit 6cfed39c2ce64ac024bbde458a9727105e0b8c66
>> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > Date:   Tue Dec 23 18:09:11 2025 +0800
>> >
>> >     ACPI: processor: Update cpuidle driver check in __acpi_processor_start()
>> >
>> >     [ Upstream commit 0089ce1c056aee547115bdc25c223f8f88c08498 ]
>> >
>> >     Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
>> >     driver registration") moved the ACPI idle driver registration to
>> >     acpi_processor_driver_init() and acpi_processor_power_init() does
>> >     not register an idle driver any more.
>> >
>> >     Accordingly, the cpuidle driver check in __acpi_processor_start() needs
>> >     to be updated to avoid calling acpi_processor_power_init() without a
>> >     cpuidle driver, in which case the registration of the cpuidle device
>> >     in that function would lead to a NULL pointer dereference in
>> >     __cpuidle_register_device().
>> >
>> >     Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver registration")
>> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >     Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> >     Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
>> >     Link: https://patch.msgid.link/20251223100914.2407069-4-lihuisong@huawei.com
>> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
>> >
>> > Reverting the commit or downgrading to 6.19.3 resolves the issue.
>> > Attached dmesg and lspci.
>>
>> Is this problem also present in 7.0-rc1?
>
>To my eyes, this commit shouldn't have been backported to 6.19.y
>because the one fixed by it was reverted in the meantime and only
>re-added in 7.0-rc1.
>
>Sasha, Greg, how do I request dropping this one from -stable?

Now reverted, thanks :)

-- 
Thanks,
Sasha

