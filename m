Return-Path: <linux-acpi+bounces-20547-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNcQJvwpcmmadwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20547-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:45:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E867794
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58A53943009
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164222DEA8F;
	Thu, 22 Jan 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="nfD4qXXI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-36.ptr.blmpb.com (sg-1-36.ptr.blmpb.com [118.26.132.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E12E265A
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086248; cv=none; b=Ifxn5dwsIFfj+y9AoNf7UMODlYDSwgKG9lGdrro9Zyjn9+WqaYKlDtaGIZItZSlld7HYL2/j3isI8XxmFBXorYAAAulrIUM1KYSROLyQY1yUZTL8I2PCTkKIBuYoBFXYpUwMO0qecs1Ck7+ASTZMEU2Sqh9iM1nZgskT80ynIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086248; c=relaxed/simple;
	bh=2IPbzqWt0TM73EMJLj1kMveRNcKsAiMWgjF+k/BmFvs=;
	h=To:Message-Id:Content-Type:Cc:Mime-Version:Subject:Date:From:
	 In-Reply-To:References; b=fmq6dwKW4/PMtjq9Tv+nY/hOG1YCPcSsPJki8zqFzFdDfncCW0J1Sr8b7s+825kRbf9kulstKSrgFeRtxQlFBr59k52rvM8h7BY+sS8n0vkY9Zby1tXmuQMVZ/ivnme/n9BZF+4aHxVQ9b7HDsANIpymWMFu/Tp7DhT0BPyRFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=nfD4qXXI; arc=none smtp.client-ip=118.26.132.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769086238;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=XCB5+7JroB4zxoAicjLIi6G6FypkufPpVImZn1JnTBk=;
 b=nfD4qXXIQxs7mMk02wXZM5UG2s/3rcJd8rOrQbNm3UTEcbpIErvdf+QFHheMR1OetoZx5l
 qofXEtxZrpnRCAtt1Ki5u39Hpirz7bi6nTGp4FK9weG45soZOG58VEejVqlfmS1ntS2oNw
 hX6BHlVx/2QPSr5W5yPFVRJpUsf7fQA1zEs1E/kIDbvqehCBjnqWhq0ZEh+W2YPKTn7hTi
 HilFu6IW68wgGJLHSo+T/xlSYqlB7j5SxvPz/4wiYHdFi+1wrTgwpgwY12A5PFzienRDmQ
 n3F1a+t+ZbQaxivcErfba6RH4D2jdmausgJiHMmoNYGcnnz2pqqFJQh5GJGQUw==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-Id: <7512bdfc-96ff-480a-a4e2-3b544f86d59d@picoheart.com>
Received: from [172.16.153.176] ([58.250.122.114]) by smtp.feishu.cn with ESMTPS; Thu, 22 Jan 2026 20:50:35 +0800
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Cc: <yang.yicong@picoheart.com>, <lenb@kernel.org>, <tglx@kernel.org>, 
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, 
	<akpm@linux-foundation.org>, <apatel@ventanamicro.com>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<geshijian@picoheart.com>, <weidong.wd@picoheart.com>, 
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
Date: Thu, 22 Jan 2026 20:50:33 +0800
X-Lms-Return-Path: <lba+269721d1c+83c81a+vger.kernel.org+yang.yicong@picoheart.com>
Content-Transfer-Encoding: quoted-printable
From: "Yicong Yang" <yang.yicong@picoheart.com>
In-Reply-To: <CAJZ5v0iwfk4hnj7Lf5hq3uo4p+_CT35ZwJUnenLOzOoGqQcsgw@mail.gmail.com>
References: <20260122073446.45628-1-yang.yicong@picoheart.com> <20260122073446.45628-2-yang.yicong@picoheart.com> <CAJZ5v0iwfk4hnj7Lf5hq3uo4p+_CT35ZwJUnenLOzOoGqQcsgw@mail.gmail.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
User-Agent: Mozilla Thunderbird
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	DMARC_NA(0.00)[picoheart.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20547-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+]
X-Rspamd-Queue-Id: 047E867794
X-Rspamd-Action: no action

On 1/22/26 7:19 PM, Rafael J. Wysocki wrote:
> On Thu, Jan 22, 2026 at 8:35=E2=80=AFAM Yicong Yang <yang.yicong@picohear=
t.com> wrote:
>>
>> The device object rescan in acpi_scan_clear_dep_fn is scheduled
>> in the system workqueue which is not guaranteed to be finished
>> before entering userspace. This will cause the problem that
>> some key devices are missed when the init task try to find them,
>> e.g. console devices and root devices (PCIe nvme, etc).
>> This issues is more possbile to happen on RISCV since these
>> devices using GSI interrupt may depend on APLIC and will be
>> scanned in acpi_scan_clear_dep_queue() after APLIC initialized.
>>
>> Fix this by scheduling the acpi_scan_clear_dep_queue() using async
>> schedule function rather than the system workqueue. The deferred
>> works will be synchronized by async_synchronize_full() before
>> entering init task.
>>
>> Update the comment as well.
>>
>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>> ---
>>  drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 416d87f9bd10..bf0d8ba9ba19 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -5,6 +5,7 @@
>>
>>  #define pr_fmt(fmt) "ACPI: " fmt
>>
>> +#include <linux/async.h>
>>  #include <linux/module.h>
>>  #include <linux/init.h>
>>  #include <linux/slab.h>
>> @@ -2365,39 +2366,35 @@ struct acpi_scan_clear_dep_work {
>>         struct acpi_device *adev;
>>  };
>>
>> -static void acpi_scan_clear_dep_fn(struct work_struct *work)
>> +static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
>>  {
>> -       struct acpi_scan_clear_dep_work *cdw;
>> -
>> -       cdw =3D container_of(work, struct acpi_scan_clear_dep_work, work=
);
>> +       struct acpi_device *adev =3D to_acpi_device(dev);
>>
>>         acpi_scan_lock_acquire();
>> -       acpi_bus_attach(cdw->adev, (void *)true);
>> +       acpi_bus_attach(adev, (void *)true);
>>         acpi_scan_lock_release();
>>
>> -       acpi_dev_put(cdw->adev);
>> -       kfree(cdw);
>> +       acpi_dev_put(adev);
>>  }
>>
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
>> +        *   before entering init task by the async_synchronize_full()
>> +        *   barrier
>> +        *
>> +        * Use _nocall variant since it'll return on failure instead of
>> +        * run the function synchronously.
>>          */
>> -       queue_work(system_dfl_wq, &cdw->work);
>> +       if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->de=
v))
>=20
> If the problem is that system_dfl_wq is too slow, why don't you just
> try a dedicated workqueue for this?
>=20
> There's no need to modify all of this code.
>=20

The problem is that these works are not finished before entering userspace,
so some key devices like console or PCIe nvme (for root device) is not read=
y
in time userspace init running.

If we use a dedicated workqueue we still need to do the synchronization
somewhere before entering the userspace to solve the problem. But that's ju=
st
what async_schedule* does: queue the function in async_wq (also an unbound =
one)
and wait finish before execute init process by async_synchronize_full(). Do=
es
it make sense?

Thanks.

