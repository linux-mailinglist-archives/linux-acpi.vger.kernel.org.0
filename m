Return-Path: <linux-acpi+bounces-1274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8068C7E29D5
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F2C28004B
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951D2941D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7429413
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 16:31:41 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80982D45;
	Mon,  6 Nov 2023 08:31:39 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id badba232969ae047; Mon, 6 Nov 2023 17:31:38 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8FC6D667790;
	Mon,  6 Nov 2023 17:31:37 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] ACPI: scan: MIPI DisCo for Imaging support
Date: Mon, 06 Nov 2023 17:03:18 +0100
Message-ID: <4542595.LvFx2qVVIh@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffeiuedtieekveekleeiieeghefhveegteeghfffvdduueefudegkeeukeffffdvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuhgvfhhirdhorhhgpdhmihhpihdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
 rhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

Hi Folks,

This is a new revision of

https://lore.kernel.org/linux-acpi/2187487.irdbgypaU6@kreacher/

addressing comments from Sakari and adding one more patch (also from
Sakari).

The main points from the original cover letter are still valid:

> The general idea is the same - CSI-2 resource descriptors, introduced in
> ACPI 6.4 and defined by
> 
> https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-i
> nterface-csi-2-connection-resource-descriptor
> 
> are found and used for creating a set of software nodes that represent the
> CSI-2 connection graph.
> 
> These software nodes need to be available before any scan handlers or ACPI
> drivers are bound to any struct acpi_device objects, so all of that is done
> at the early stage of ACPI device enumeration, but unnecessary ACPI
> namespace walks are avoided.
> 
> The CSI-2 software nodes are populated with data extracted from the CSI-2
> resource descriptors themselves and from device properties defined by the
> MIPI DisCo for Imaging specification (see
> https://www.mipi.org/specifications/mipi-disco-imaging).
> 
> Patches [4,6/6] come from the original series directly, but the other
> patches have been changes substantially, so I've decided to re-start patch
> series versioning from scratch.

The series is based on the current mainline.

Thanks!




