Return-Path: <linux-acpi+bounces-20580-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJzwIu48c2kztgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20580-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 10:18:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E476731C9
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8B3130193B4
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF7305E32;
	Fri, 23 Jan 2026 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUjOiWO1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EA2F3C3F
	for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159911; cv=none; b=Ho8CgSlOHQgOV2fQ4bU45Wg7VYwxqRjaf74prX+aDPy2/XB/JSU3orTzbQE+SouvdReBci1uUf9Ox9VGP2V+ugvvudazIVa0LxlhOh5VBdTg2W213IH4zqBDGiIQMlu/9BjRUQm9JAHk0dAQCpPzIbHTF287q3OF1LGH8WxQTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159911; c=relaxed/simple;
	bh=m+UFmeBBP/QBaJSGO0vTDNL2nYoouTDWi3Dd8eHpFsM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gNpw14u7WMNUQB60y+UpZZNIaJapCWYbmaB3EeOgtFp4HOeVcYljEnxNi2krzLitopz1M8P+z5HoTsKE6PK07H6iopGAlv0tvfuI1kNMKEufmd/bbNHH+sDcA9gr6YMQaLqiDMmSY7k/eDzUEuunhXZefJnvvuiGCP/z6ZtXFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUjOiWO1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769159909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4adb7RBzc9M2pMG+W+7qzLvf6ZphpXm5a1NDpOPzIFw=;
	b=FUjOiWO1RwvYLipVHQZQoMtqzblOooAL40IEbCHvmqN6dVjd1Cak+HPZaCRS9j2p84RJym
	E2xiBM1rfnsRWDXY967M+vnHHNi5xG3N1ezh651UkfJo0mErPYbTnYN/1EFtOF3TnDEKB5
	kmNOuFnsdl+KErEkZVBSBtEiMIXucd8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-wbPhgd-0MoiG_jQ0u7Dr_w-1; Fri,
 23 Jan 2026 04:18:25 -0500
X-MC-Unique: wbPhgd-0MoiG_jQ0u7Dr_w-1
X-Mimecast-MFC-AGG-ID: wbPhgd-0MoiG_jQ0u7Dr_w_1769159903
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 423181955F2C;
	Fri, 23 Jan 2026 09:18:22 +0000 (UTC)
Received: from [10.45.224.124] (unknown [10.45.224.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 639831800665;
	Fri, 23 Jan 2026 09:18:16 +0000 (UTC)
Message-ID: <65e558ee-0b74-4197-91bf-e109662e5fd6@redhat.com>
Date: Fri, 23 Jan 2026 10:18:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ivan Vecera <ivecera@redhat.com>
Subject: Re: [Proposal,Question - refresh] ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
To: Andrew Lunn <andrew@lunn.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Mark Brown <broonie@kernel.org>, Jan Aleszczyk <jaleszcz@redhat.com>,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 linux-acpi@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
 <a6e64236-d164-40d1-85d3-caf7d27fc952@lunn.ch>
 <c87cecdc-8ba5-4831-889f-0d903ae7b5ca@redhat.com>
 <11ebf2de-bbd4-4aec-befa-cf0877cfa960@lunn.ch>
 <c0de7c8b-8fea-4e76-bec4-6337153fc7a1@redhat.com>
 <24e081fd-1b59-4951-96fc-f87ef7f3172f@lunn.ch>
Content-Language: en-US
In-Reply-To: <24e081fd-1b59-4951-96fc-f87ef7f3172f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-20580-lists,linux-acpi=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E476731C9
X-Rspamd-Action: no action



On 1/22/26 8:57 PM, Andrew Lunn wrote:
>> No, absolutely not. The drivers for these devices reside entirely in the
>> kernel. They handle all the low-level register access, mux config, and
>> hardware abstraction.
>>
>> The userspace (e.g. synce4l daemon) is purely a Policy Engine. It uses
>> a  generic, hardware-agnostic Netlink API to send high-level commands
>> like "Lock to Pin 0" or "Set Priority 1". The in-kernel driver
>> translates these generic commands into the specific register writes
>> required for that chip (ZL3073x, etc.).
> 
> Great. But i've not seen the needed board configuration to allow
> this. Where do you describe if the ingress inverter is needed? The
> egress inverter? The clock divider on ingress, the clock divider on
> egress. The frequency of the clock feeding the package, etc.

On this specific platform, the DPLL device is not a "blank slate" at
boot. It has internal flash that is pre-programmed by the OEM during
manufacturing. So the ACPI does not need to store exact state of each
piece of the HW you mentioned (like dividers, inverters, etc.)

The flash contains the board-specific initialization:
* Base frequencies (XO inputs)
* Default divider values
* Signal conditioning (inverters, impedance) required for the specific
   board layout.

When the OS loads, the DPLL state is already in a valid, board-compliant
state. The zl3073x driver reads this current state from the hardware.

The one thing the DPLL's internal flash cannot know is "Which OS device
is connected to my pin X?". The DPLL knows "pin X is configured for
25MHz," but it doesn't know that "pin X is physically wired to eth0
(PCIe Bus 04:00.0)." and cannot provide such information.

At this point only ACPI know such information as it knows the board
topology.

This is precisely why we need the ACPI schema I proposed. We do not need
ACPI to replicate the entire configuration that already exists in the
DPLL's flash. We only need ACPI to bridge that specific Topology Gap:

* ACPI: "DPLL pin 0 connected to this NIC as 'rclk'."
         "DPLL pin 1 connected to this NIC as 'synce_ref'."
* NIC Driver: "DPLL pin 0 is connected to my recovered clock"
               "DPLL pin 1 is connected to my SyncE ref"
* Userspace (synce4l): Uses this information map to make runtime
   decisions (e.g., "Network condition changed, switch DPLL to lock on
   NIC2's recovered-clock").

>> But I don't use CCF bindings in this design, this design is about
>> representing an opaque wire between two devices.
> 
> Is it really opaque? Don't you need to know its frequency, so you can
> set the ingress divider? You can either ask it what it is, or you can
> have a board property. Don't you want to know its phase? So you can
> enable/disable the ingress inverter?

Yes, the system needs to know this. But the NIC driver does not. The NIC
driver just says "I am wired to pins X,Y." The DPLL driver monitors DPLL
device and its pins states by querying the hardware, reports state 
(device lock status, pins' phase offset, signal quality, fractional
frequency offset, etc.) to userspace (e.g. synce4l) and accepts new
commands from it to change the device & pins configuration (pins'
priority, phase compensation etc.).

Thanks,
Ivan


