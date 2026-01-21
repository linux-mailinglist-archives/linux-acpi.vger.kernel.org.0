Return-Path: <linux-acpi+bounces-20490-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIRCMrPzcGmgbAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20490-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 16:41:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3493A595E3
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C185AA6AFC
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6C410D34;
	Wed, 21 Jan 2026 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEAdQNk5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C93D5239
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jan 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006593; cv=none; b=oZPSr0/9qM3cjDvdkvuAOBbO7Hme0OBhCqb0ErvPZ2dEgQkLC+5Q3SgBWBV+5574486PfNn7k9d4NFldS9a+2vIHvA1BlKPVpx7Q7JMiUWAsp/0LPUn2jjvJIuv5eEtZiULs4hpMr8v6lTa9kEBectD9zI2mWTDYcl82bcRLU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006593; c=relaxed/simple;
	bh=gHPiL96eNjmTlPWAfoWRA1J6NuEr/c2dfcWyU2idECo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=YzxmtWfEA9jafpni1apDoNAwknDQY+HfJC9NKPacRyeYzbgkm42IP+hA9L5W53ejs39o4q/PBxeYco8wtSSNR2GesBRDXIuhvbx/DglE57xXMagQuMDYGgiUP4ITXUMwzJz2msNi74qUsorIhp9wDyvRBjLln40HfnsoCEuinkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEAdQNk5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769006590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqdkNxHcbaWyGUvBz/H79CvvP2GDktchKPKGebDCIkY=;
	b=PEAdQNk5lyqy4eZZgRA2FNLCRG6ZE8CEOEJfVCWAhQ7LpFbVpY/zo5wcD43x4+5d7IzRrL
	KjZpRY6iMVMwD/96gdH1r4y7z+Q9BF6/JzQ6XIpdr4RszqWiwlXeCg7Q/Ut0I7wm9aE6a6
	alIJ5ooeiY8MnMAHgBd4bsi+/yPF92s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-a-HIUmV3Nn2btqiK18PwMA-1; Wed,
 21 Jan 2026 09:43:07 -0500
X-MC-Unique: a-HIUmV3Nn2btqiK18PwMA-1
X-Mimecast-MFC-AGG-ID: a-HIUmV3Nn2btqiK18PwMA_1769006585
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05E861954B12;
	Wed, 21 Jan 2026 14:43:02 +0000 (UTC)
Received: from [10.45.225.85] (unknown [10.45.225.85])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52E2A1800577;
	Wed, 21 Jan 2026 14:42:56 +0000 (UTC)
Message-ID: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
Date: Wed, 21 Jan 2026 15:42:54 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ivan Vecera <ivecera@redhat.com>
Subject: [Proposal,Question - refresh] ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>,
 Jan Aleszczyk <jaleszcz@redhat.com>, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, linux-acpi@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-20490-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3493A595E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andy, Rafael and others,

(based on the previous thread [1] - now involving more people from
  networking and DPLL)

Thank you for the insights on _CRS and ClockInput.

I think we have circled the issue enough to identify the core disconnect:
* While the physical signals on these wires are indeed clocks (10MHz,
   etc.), from the OS driver perspective, this is not a "Clock Resource"
   issue. The NIC driver does not need to gate, rate-set, or power-manage
   these clocks (which is what _CRS/ClockInput implies).
* Instead, the NIC driver simply needs a Topology Map. It needs to know:
   "My Port 0 (Consumer) is physically wired to DPLL Pin 3 (Provider)."

The NIC driver needs this Pin Index (3) specifically to report it via
the RtNetlink. This allows the userspace daemon (e.g., synce4l or
linux-ptp) to see the relationship and decide to configure the DPLL via 
the DPLL Netlink API to lock onto that specific input.

A generic ClockInput resource in _CRS is anonymous and unordered. The OS
abstracts it into a handle, but it fails to convey the specific pin
index required for this userspace reporting.

Since ACPI lacks a native "Graph/Topology" object for inter-device
dependencies of this nature, and _CRS obscures the index information
required by userspace, I propose we treat _DSD properties as the
de-facto standard [2] for modeling SyncE topology in ACPI.

To avoid the confusion Andy mentioned regarding "Clock Bindings" in
ACPI, I suggest we explicitly define a schema using 'dpll-' prefixed
properties. This effectively decouples it from the Clock subsystem
expectations and treats it purely as a wiring map.

Proposed ACPI Representation with proposed documentation [3]

If the ACPI maintainers and Netdev maintainers agree that this
_DSD-based topology map is the acceptable "Pragmatic Standard" for this
feature, I will document this schema in the kernel documentation and
proceed with the implementation.

This solves the immediate need for an upcoming Intel SyncE enabled
platform and provides a consistent blueprint for other vendors
implementing SyncE on ACPI.

Regards,
Ivan

[1] 
https://lore.kernel.org/linux-acpi/3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com/
[2] 
https://docs.kernel.org/firmware-guide/acpi/dsd/data-node-references.html
[3] https://gist.github.com/ivecera/964c25f47f688f44ec70984742cf7fbd


