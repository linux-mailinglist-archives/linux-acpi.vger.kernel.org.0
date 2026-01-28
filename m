Return-Path: <linux-acpi+bounces-20701-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPwLJRKreWmuyQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20701-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 07:22:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E49D64B
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 07:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76105300A116
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 06:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4230ACEB;
	Wed, 28 Jan 2026 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="IPZikjva"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-31.ptr.blmpb.com (sg-1-31.ptr.blmpb.com [118.26.132.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF262D1931
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769581326; cv=none; b=Grj5bwwNxm/IidM/XaYRYsN4NsHS/thakkjBoBA4tigTtJsHVzrFTUKYi8Kvd2WAszDdrQA1AQdMUrGYGnP3+cYLXNwmDnGlvlJYizrMh/K18kY4ndsjysIo7bhDSuzNHrAr/TpjW4qSRwT44Md+K4HQuaV/3cLmYVBfJ7On0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769581326; c=relaxed/simple;
	bh=moWekh3WQrvMb0kxuTwGdM73PAxUo72CYBxgjcWD9i4=;
	h=In-Reply-To:From:Mime-Version:Date:References:Content-Type:To:Cc:
	 Subject:Message-Id; b=GKUOlIK6j0HslKhSXvjUEYSsuk2xqCtJt5hs5EmicgxYee9NIcWwfueOKMwasxgBoPmnqBfb0jKiKrB91qgrFKHhKLkCAq2VSanDlHEuBaKDYQctwIkNLyHNyhvNiT3NlYSPi5lPRAN2S69M/GgAbi5hMUshvmUwFtZ3j3EqtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=IPZikjva; arc=none smtp.client-ip=118.26.132.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769581318;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=jYmPdjQkc7jphb0+v4Xl7jw9RPWZnpasphOMWgbn5HI=;
 b=IPZikjvaWPzjeLundil6dOH0pQm7H84OUGoOrGfm89LOD2rzeU+DKrtgTAAlMY4/4CdqaO
 QXFU0HitpzxVCbTA9oW7lyKQuSb1MMBZ3YNFw63g18cIIBedNtfAV9FDmQQDBQfqBuN2LH
 x5OSrbak2j4MTq128R+YqrrvrV/avYRkOtPgHmbweQIzkzF8LEjlEDn7WGuqFLEHaMK2MK
 XgJ+hlGEyQYT4u6C20Gro/OpoXLVnxlybVhU+NaXcr2t1NPsPplUlGFnO0G2pxWF4pywor
 fz70L60bxEaQVfY/xdcVtZX2z8f/+JqJ84AMkQsWJr7H3br1HcNl73vVq3Rivw==
X-Lms-Return-Path: <lba+26979ab04+045e05+vger.kernel.org+yang.yicong@picoheart.com>
In-Reply-To: <CAJZ5v0igWB+c1ER15_0FSEBXfAaAUBXRwx3K_rt-POdsAYui8Q@mail.gmail.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Date: Wed, 28 Jan 2026 14:21:52 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
References: <20260126070427.64574-1-yang.yicong@picoheart.com> <CAJZ5v0igWB+c1ER15_0FSEBXfAaAUBXRwx3K_rt-POdsAYui8Q@mail.gmail.com>
Received: from [100.86.224.191] ([120.234.91.239]) by smtp.feishu.cn with ESMTPS; Wed, 28 Jan 2026 14:21:55 +0800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: <yang.yicong@picoheart.com>, <lenb@kernel.org>, <tglx@kernel.org>, 
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, 
	<akpm@linux-foundation.org>, <apatel@ventanamicro.com>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<geshijian@picoheart.com>, <weidong.wd@picoheart.com>, 
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
Message-Id: <95a76a02-d9b3-494c-86fc-bb7517117d80@picoheart.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[picoheart.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20701-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[picoheart-com.20200927.dkim.feishu.cn:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 812E49D64B
X-Rspamd-Action: no action

On 1/28/26 4:56 AM, Rafael J. Wysocki wrote:
> On Mon, Jan 26, 2026 at 8:04=E2=80=AFAM Yicong Yang <yang.yicong@picohear=
t.com> wrote:
>>

[...]

>>  static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
>>  {
>> -       struct acpi_scan_clear_dep_work *cdw;
>> -
>>         if (adev->dep_unmet)
>>                 return false;
>>
>> -       cdw =3D kmalloc(sizeof(*cdw), GFP_KERNEL);
>> -       if (!cdw)
>> -               return false;
>> -
>> -       cdw->adev =3D adev;
>> -       INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
>>         /*
>> -        * Since the work function may block on the lock until the entir=
e
>> -        * initial enumeration of devices is complete, put it into the u=
nbound
>> -        * workqueue.
>> +        * Async schedule the deferred acpi_scan_clear_dep_fn() since:
>> +        * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
>> +        *   be acquired under acpi_dep_list_lock (held here)
>> +        * - the deferred work at boot stage is ensured to be finished
>> +        *   before userspace init task by the async_synchronize_full()
>> +        *   barrier
>> +        *
>> +        * Use _nocall variant since it'll return on failure instead of
>> +        * run the function synchronously.
>>          */
>> -       queue_work(system_dfl_wq, &cdw->work);
>> +       if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->de=
v))
>> +               return false;
>>
>>         return true;
>=20
> What about doing
>=20
>     return !!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev=
);
>=20
> here?
>=20

sure, will update. the '!!' conversion could be dropped as
async_schedule_dev_nocall also returns boolean.

thanks.

