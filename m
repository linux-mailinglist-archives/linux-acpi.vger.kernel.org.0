Return-Path: <linux-acpi+bounces-34-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3877A9C3C
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A2328113F
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BB03D982
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:43:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B283F4C1
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:10:47 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336CAF96A;
	Thu, 21 Sep 2023 11:07:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 66c059efcc43437d; Thu, 21 Sep 2023 20:07:33 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id 0A8DA664EBE;
	Thu, 21 Sep 2023 20:07:33 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 00/13] thermal: ACPI: More ACPI thermal improvements and modification of thermal instances
Date: Thu, 21 Sep 2023 19:46:55 +0200
Message-ID: <1957441.PYKUYFuaPT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgr
 nhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi All,

The ACPI thermal driver has undergone some significant changes recently, but
there is still room for improvements in it.

First off, it turns out that a small rearrangement of its internal data
structures allows code duplication in it to be reduced quite a bit (patches
[01-04/13].

Next, by changing the way it binds cooling devices to thermal zones (and trips
within them), the use of trip point indices can be eliminated from it (patch
[11/13]) which then allows its internal data structures to be simplified even
further (patch [12/13]).

However, in order to make those latter changes, it is useful to modify struct
thermal_instance to carry a trip pointer instead a trip index (patch [05/13])
which then allows the core to be adjusted to facilitate using trip pointers for
cooling device binding and unbinding (patch [10/13]).

Meanwhile, the modification of struct thermal_instance mentioned above also
helps to reduce the thermal governors overhead related to using
__thermal_zone_get_trip() that carries out bounds checking and copies trip
point data which both are not necessary in the governor code.  Some related
cleanups of thermal governors can be done as well (patches [06-09/13].

Finally, it is prudent to visually distinguish the names of structure fields
and variables that carry temperature values in different units, so patch
[13/13] changes the names of those items in the ACPI thermal driver that are
used to store temperature values in deci-Kelvin.

This series is on top of the series of ACPI thermal driver posted last week:

https://patchwork.kernel.org/project/linux-acpi/list/?series=783543

and a couple of recent thermal core patches:

https://patchwork.kernel.org/project/linux-pm/patch/12296181.O9o76ZdvQC@kreacher/
https://patchwork.kernel.org/project/linux-pm/patch/5981326.lOV4Wx5bFT@kreacher/

It will be exposed in a separate git branch for easier access.

Please see the individual patch changelogs for details.

Thanks!




