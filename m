Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E4340CF3
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhCRS3O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 14:29:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51570 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhCRS3N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2021 14:29:13 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 90fddb0d8e680081; Thu, 18 Mar 2021 19:29:11 +0100
Received: from kreacher.localnet (89-64-80-250.dynamic.chello.pl [89.64.80.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2A6C9668FA9;
        Thu, 18 Mar 2021 19:29:10 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v2 0/2] ACPI: scan: Turn off unused power resources during initialization
Date:   Thu, 18 Mar 2021 19:23:38 +0100
Message-ID: <3108574.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefiedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvedufefggeeutdejvdfhteevgeeludevueevvdejkeelfefhudfhfeehkefffeevnecukfhppeekledrieegrdektddrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrvdehtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvihgurdgvrdgsohigsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Power resources that aren't associated with any devices are expected to be
turned off by the OS, but Linux only does that during resume from
suspend-to-RAM.  That turns out to be problematic, so turn them off during
system initialization too (patch [1/2]).

In addition to that, turn them off unconditionally, without checking the
current status, which should be safe and may help to work around firmware
issues (patch [2/2]).

Please refer to the patch changelogs for details.

Thanks!



