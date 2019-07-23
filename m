Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13969711C2
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2019 08:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfGWGOW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jul 2019 02:14:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33203 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbfGWGOW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jul 2019 02:14:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so18584101pfq.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jul 2019 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuhDAdrwQAvGhhF1l4sTnH2/cYgn8v3uFIkNwLOWcSI=;
        b=GLW0xIF/ikmhDxxaWkwedXQ3YAtiEnzbtfMJ9HikV4tL95rqEh2fkcB6NkefS0TByU
         +QQ1hhPN/eokT2aVxg0eTyR+90qMUvCEVt61eF45mxKmxYTxyaL9RYps9BAZTMO/3cDb
         9C4NZ3uhWr2iKuhcCIrARd0ii+fMDfM0DIeWksAUC6ORyiERFbDn1C2vq8S/hkwYbIHB
         g/xyhH2PR0cFm9DdI53v5Y67tYeflXFdxVK6L0Q8ZnqYVmdDUpOGII7k1z1MNqs5JNRA
         OPWC2yrAd7K4gFy5nbRUzC6OGpMxbNPocvSPv+RbcxEN1BWEsoCoEgPiI4t0kVS5DIyX
         10dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuhDAdrwQAvGhhF1l4sTnH2/cYgn8v3uFIkNwLOWcSI=;
        b=Nvsnx1e/gm6EP2gMflQn2Ujj/wW4+okrhBwH/hV0Uyq1q8hQ2QY2a7g7gUYbMowcQK
         IZfLxtZ2NIsm+6Cmoe+r98xrlbIpKeeG/k+Pb30hx1viblPeRf4MRMvoqGWyTdkaYd75
         xGqu5zhRn2lGNNPYzckADI9dGtzi/4yVqmkwmEd2O/j5H/R8ejSksx5VRssZuZ221DeZ
         bGqQztZ5BYwZzLKLWdEo2209Q75ovMPvQ61ESNqRn436HjDlKNJ1VL70P3y70hXLw0U+
         RCKWHICUfjOsq4ScB6O9N+eB8afOyXVfwCFwfohPbrSsrLNPEG6RyLKhMj8T8lfqWxSb
         tfug==
X-Gm-Message-State: APjAAAW8vF+HhSuTgZrKxvKx+WwMqhlto3C7DcjLNdzWc9+g1/3Rfkxk
        l3c/dZwdDKDb6HiT1DFa2AHlrw==
X-Google-Smtp-Source: APXvYqxP6bnPVRQ1MCBwzGR7VTcX3M/ry8bfvkqazsDReUg7h0RInIBa5NIHj45OVf4NXWgl6klj/w==
X-Received: by 2002:a63:c106:: with SMTP id w6mr75584400pgf.422.1563862461180;
        Mon, 22 Jul 2019 23:14:21 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o95sm36186558pjb.4.2019.07.22.23.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, devel@acpica.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 00/10] cpufreq: Migrate users of policy notifiers to QoS requests
Date:   Tue, 23 Jul 2019 11:44:00 +0530
Message-Id: <cover.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

Now that cpufreq core supports taking QoS requests for min/max cpu
frequencies, lets migrate rest of the users to using them instead of the
policy notifiers.

The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically,
though they are also used by arch_topology stuff now. So the policy
notifiers aren't completely removed.

Boot tested on my x86 PC and ARM hikey board.

This has already gone through build bot for a few days now.

V1->V2:
- Added Acked-by tags
- Reordered to keep cleanups at the bottom
- Rebased over 5.3-rc1

--
viresh

Viresh Kumar (10):
  cpufreq: Add policy create/remove notifiers
  thermal: cpu_cooling: Switch to QoS requests instead of cpufreq
    notifier
  powerpc: macintosh: Switch to QoS requests instead of cpufreq notifier
  cpufreq: powerpc_cbe: Switch to QoS requests instead of cpufreq
    notifier
  ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier
  arch_topology: Use CPUFREQ_CREATE_POLICY instead of CPUFREQ_NOTIFY
  video: sa1100fb: Remove cpufreq policy notifier
  video: pxafb: Remove cpufreq policy notifier
  cpufreq: Remove CPUFREQ_ADJUST and CPUFREQ_NOTIFY policy notifier
    events
  Documentation: cpufreq: Update policy notifier documentation

 Documentation/cpu-freq/core.txt            |  16 +--
 drivers/acpi/processor_driver.c            |  44 ++++++++-
 drivers/acpi/processor_perflib.c           | 106 +++++++++-----------
 drivers/acpi/processor_thermal.c           |  81 ++++++++-------
 drivers/base/arch_topology.c               |   2 +-
 drivers/cpufreq/cpufreq.c                  |  51 ++++------
 drivers/cpufreq/ppc_cbe_cpufreq.c          |  19 +++-
 drivers/cpufreq/ppc_cbe_cpufreq.h          |   8 ++
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c      |  96 +++++++++++-------
 drivers/macintosh/windfarm_cpufreq_clamp.c |  77 ++++++++++-----
 drivers/thermal/cpu_cooling.c              | 110 +++++----------------
 drivers/video/fbdev/pxafb.c                |  21 ----
 drivers/video/fbdev/pxafb.h                |   1 -
 drivers/video/fbdev/sa1100fb.c             |  27 -----
 drivers/video/fbdev/sa1100fb.h             |   1 -
 include/acpi/processor.h                   |  22 +++--
 include/linux/cpufreq.h                    |   4 +-
 17 files changed, 327 insertions(+), 359 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

