Return-Path: <linux-acpi+bounces-20345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F888D20FEE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 20:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8AF3034A20
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19A33E34D;
	Wed, 14 Jan 2026 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgnIV6BW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD14502A
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418353; cv=none; b=kDj7d7h1RScwc6uDga89KfyrRcR9pxxtCp9CSzbUoo+EnTB7b/ieSNCcTaK/oGVHp8e4QSvtwblnni1nzgZfh9FNDyTOtFLrTqyU6vWt9LVtvUsujUUrxHio8OyU6oIyLJi2sFv2FLWfAPdQuaMKvdXZtf4idhI3SV8DlZrKEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418353; c=relaxed/simple;
	bh=oTYnf0c2tNgX0YwcVJZYDFW4B7KfgZ2Z9DdFz6nyK5E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=li1CtEn8IWThd8COVZ3SZdm0/cmUYOUB8KPFNHSH1yua9JTOT++OTD4LoSp1++GBfWVqZAv+BU2VqluqwJ3uAaIku2Bjw2iwWZIKAaHuhwNsPJmcoOlybdz++TT+YBhT1YOl2Tsjf82UBwjqOQy+KgEUSQ8rdD7rq1pdDdYkkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgnIV6BW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768418351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4+LjYZYITMA7puIb6+F/XBU/KwJdiWe+DRHK6wwUO0g=;
	b=XgnIV6BWk2/Cp0m7aBEUPYh2c8GK2IJcCgYnZGUSExNQ5vmM92CYN5LRsx962fC5N9zqCK
	SRSDh4wWrcMEdw82pChZnsn5iBxS8lmDdlBDFf8KFGEOWfLKKS3kvcz7iE7EhaExkBVHoX
	j0qHJNA1Lys6bwTA3uhWMIjeTOVd514=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-tg9zWVKFPOCvH2ArxwUVag-1; Wed,
 14 Jan 2026 14:19:10 -0500
X-MC-Unique: tg9zWVKFPOCvH2ArxwUVag-1
X-Mimecast-MFC-AGG-ID: tg9zWVKFPOCvH2ArxwUVag_1768418348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9826119560A5;
	Wed, 14 Jan 2026 19:19:08 +0000 (UTC)
Received: from [10.44.32.45] (unknown [10.44.32.45])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B48CC180009E;
	Wed, 14 Jan 2026 19:19:06 +0000 (UTC)
Message-ID: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
Date: Wed, 14 Jan 2026 20:19:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-acpi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
From: Ivan Vecera <ivecera@redhat.com>
Subject: [Question] Best practice for ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi all,

I would like to ask for your opinion regarding an ACPI implementation
detail for a patch-set I currently have on the netdev mailing list [1].

The patch-set adds support for modeling the relationship between a DPLL
device (provider) and an Ethernet controller/PHY (consumer) to support
SyncE (Synchronous Ethernet). The topology requires the Ethernet
controller/PHY to reference specific pins (sub-nodes) of the DPLL
device.

Although the target driver (ice) in the patch-set is primarily used in
ACPI environments, I aimed for a firmware-agnostic approach using the
fwnode API.

Provider (DPLL):
The DPLL device uses _DSD properties mirroring the definition in the DT
bindings [2]. The pins are represented as sub-nodes. ACPI example [3].

Consumer (Ethernet):
I defined a new DT schema for the consumer using properties dpll-pins
nd dpll-pin-names. And in ACPI, I intend to use hierarchical data
extension (_DSD) to reference the DPLL pin sub-nodes from the Ethernet 
controller package [4], effectively mirroring the DT phandle referencing
mechanism.

Question:
Is reusing the DT binding definitions within ACPI _DSD (to allow unified
fwnode property parsing) the recommended approach for this type of
device relationship?

Or should I define strictly ACPI-specific bindings/objects, considering
that the DT bindings for this feature are also new and currently under
review?

I want to ensure I am not violating any ACPI abstraction layers by
relying too heavily on the DT-style representation in _DSD.

Thanks for your guidance.

Regards,
Ivan

[1] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=1040080&state=*
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dpll
[3] https://github.com/ivecera/zl3073x-acpi/blob/main/sample1.asl
[4] https://github.com/ivecera/zl3073x-acpi/blob/main/dpllnic.asl


