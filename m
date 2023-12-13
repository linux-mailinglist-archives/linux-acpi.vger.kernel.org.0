Return-Path: <linux-acpi+bounces-2310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B7880E7E9
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 10:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2A1C20DF1
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332F58AAB;
	Tue, 12 Dec 2023 09:40:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5D8107;
	Tue, 12 Dec 2023 01:40:25 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 076B145FA0;
	Tue, 12 Dec 2023 10:40:24 +0100 (CET)
Message-ID: <857901f7-0315-4e5b-9646-ce328e020d45@proxmox.com>
Date: Tue, 12 Dec 2023 10:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20231211161836.GA914318@bhelgaas>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231211161836.GA914318@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 11.12.23 um 17:18 schrieb Bjorn Helgaas:
> 
> Thanks, I opened https://bugzilla.kernel.org/show_bug.cgi?id=218255
> and attached this dmesg log there so this doesn't get lost or expired
> from pastebin.com.
> 

Thank you!

> IIUC this is a log from when it fails.  Can you attach the
> corresponding log when it works correctly?
> 

Yes, it is. I attached the dmesg log for both, a run with the reverts
and a run without the reverts where the issue did not trigger by chance.

Best Regards,
Fiona


