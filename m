Return-Path: <linux-acpi+bounces-805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049547D1413
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CD8282569
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1371EA77
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F91D52E
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 14:49:56 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A0D5F;
	Fri, 20 Oct 2023 07:49:54 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 36c620263d67cc07; Fri, 20 Oct 2023 16:49:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 58FFB667008;
	Fri, 20 Oct 2023 16:49:52 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] ACPI: scan: MIPI DiSco for Imaging support
Date: Fri, 20 Oct 2023 16:33:56 +0200
Message-ID: <2187487.irdbgypaU6@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffieeutdeikeevkeelieeigeehhfevgeetgefhffdvudeufedugeekueekffffvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhuvghfihdrohhrghdpmhhiphhirdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
 gh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

Hi Folks,

This is a new revision of

https://lore.kernel.org/linux-acpi/13276375.uLZWGnKmhe@kreacher/

which was reported to have issues and it took time to revisit it.

> The main points from the original cover letter are still valid:
> 
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
> MIPI DiSco for Imaging specification (see
> https://www.mipi.org/specifications/mipi-disco-imaging).
> 
> Patches [4,6/6] come from the original series directly, but the other
> patches have been changes substantially, so I've decided to re-start patch
> series versioning from scratch.

The v2 addresses at least 3 issues found in the v1 by code inspection:

* A port_count field incrementation was missing in acpi_mipi_scan_crs_csi2(),
  so its value for all of the devices having CSI2 resources in _CRS was always
  1 (and it should be equal to the number of valid CSI2 connection resources).

* Some acpi_mipi_crs_csi2_list members could be freed prematurely, so they were
  inaccessible when extract_crs_csi2_conn_info() attempted to access them.

* A check of remote_swnodes() against NULL was missing, which could result in
  a crash in a case when the swnodes memory could not be allocated for some
  acpi_mipi_crs_csi2_list entries.

Apart from that, it rearranges the code somewhat to make it easier to follow
and to avoid premature freeing of memory in it in general and the new file
added by it is now called mipi-di.c (instead of mipi-disco-imaging.c) for
compactness.

The series is based on current linux-next.

Thanks!




