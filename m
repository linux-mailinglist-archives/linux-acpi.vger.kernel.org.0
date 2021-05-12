Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B0A37BFD3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhELOXD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 10:23:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46402 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhELOXB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 10:23:01 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 602755e1f585e2c0; Wed, 12 May 2021 16:21:51 +0200
Received: from kreacher.localnet (89-64-81-242.dynamic.chello.pl [89.64.81.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id DE39E6695E9;
        Wed, 12 May 2021 16:21:50 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/2] cpufreq: intel_pstate: HWP support on hybrid processors
Date:   Wed, 12 May 2021 16:14:18 +0200
Message-ID: <2212930.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.242
X-CLIENT-HOSTNAME: 89-64-81-242.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdehvddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepkeelrdeigedrkedurddvgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurddvgedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhdrsghrohifnhesihhnthgvlhdrtghomhdprhgtphhtthhopeihuhdrtgdrtghhvghnsehinhhtvghlrdgtohhm
 pdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

In Intel Hybrid processors there are cores with different micro-architecture,
so the relationship between CPU frequency and performance is generally not
uniform across all CPUs.  Because the units of CPU performance used in the
MSR_HWP_CAPABILITIES and MSR_HWP_REQUEST registers are the same for all CPUs,
the scaling between HWP performance levels and frequency generally depends on
the core type and it is not uniform across all CPUs either, so some assumptions
made by intel_pstate are not applicable to hybrid processors.

As the scaling factor between HWP performance and frequency will now generally
depend on the CPU, in particular it cannot be assumed to be equal to the
scaling factor between P-states and frequency for all CPUs which has been one
of the assumptions made so far by intel_pstate.  Unfortunately, in general it
is not very straightforward to determine that scaling factor which is the
purpose of patch [2/2] (please refer to the changelog of that patch for
details).

Moreover, two of the global sysfs attributes exposed by intel_pstate only work
as expected if all CPUs have the same number of HWP performance levels, so it
is better to avoid exposing those attributes when running on hybrid processors,
which is taken care of by patch [1/2].

Thanks!



