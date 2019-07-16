Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7316A5D5
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfGPJtZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 05:49:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35456 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPJtY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 05:49:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so2865292pgr.2
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jul 2019 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOxxYg1gkl1a/ysoqs6BZ37K9CF/kS15FrSEdYGMrcE=;
        b=EpO9lcJJCleKXGgnbBcmT0vu4HaYAgr9cMkeEXTp7CyyD4yV+yFnl1mxqPgDrOOQFv
         uX4IGgyhvlC0Ycx0OgWkLzAlykS9IJaLFR2yukDVSE+KIOS23muUiLalQLQa03Wse+/Y
         FIaNNN0uwHO6LUKp+rICHDSjzUm8mrleslaGLlOHrsYK0tU9PucY0BVtOnLOBG1WYHJT
         Y41fadi2cSZHeYEnTHQY9LiafFF2DeAdHLwZ6m+FmkVnzFZMM3swsG+hfik7+0CzsULk
         CfxvI0eWRu5hr0QvUkVSUcvOiO4XnmJcvSFY/IXMPQ2Dp5U1QyJgJ6fT0ADilqS/soWL
         b0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOxxYg1gkl1a/ysoqs6BZ37K9CF/kS15FrSEdYGMrcE=;
        b=Ranj7l1PXS7H9YyBUcIFexFZN5JHfMuf9qmBsuQYdZC+aRQKbQprd1Q5hv1OKBl5bC
         3CH0ZwML5WGzuHTCE770asCa6NNGNycfkYHUi4GRiE+PEIIgwaJBgeXh9P2GpOmm2V16
         ejkkUSqO5ng+V1r7NUaVe2GQo5bQU1Kvxpf6s2JxTNYi3AQhVEGUzh80BPh0mkl7FaGm
         6RT+zrlTG4IBNwKKfNhkv1eWKBWpjSSbuHcl2obEa+ERN4dyL+lFeZnj8/hlVUx6Ifg8
         EZVF5OaBwiJSDRkelnONOoimTbtQLPGCab9m3G1GQnLU+jUaQ/k4E3wv2h1sDCoEkaz3
         bsJg==
X-Gm-Message-State: APjAAAXzjZq9gPJrBh/a9d1P1NbwNelz5c2Jfq+hsdheE4G/FEq92/Sn
        E04omv1QC4cR5P8rCItiGuJ36oNkrEM=
X-Google-Smtp-Source: APXvYqw5SKHgwSs1ZhYtTM+f2bW5/Eb88H6yQX28Ko/X85JMot8sov7jCBSAQXBcHVwxNzo9et7lnA==
X-Received: by 2002:a65:4189:: with SMTP id a9mr7021968pgq.399.1563270563855;
        Tue, 16 Jul 2019 02:49:23 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c69sm22793150pje.6.2019.07.16.02.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:49:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javi Merino <javi.merino@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, devel@acpica.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/10] cpufreq: Migrate users of policy notifiers to QoS requests
Date:   Tue, 16 Jul 2019 15:18:56 +0530
Message-Id: <cover.1563269894.git.viresh.kumar@linaro.org>
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
CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
the policy notifiers aren't completely removed.

Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)

This has already gone through build bot for a few days now.

--
viresh

Viresh Kumar (10):
  cpufreq: Add policy create/remove notifiers
  video: sa1100fb: Remove cpufreq policy notifier
  video: pxafb: Remove cpufreq policy notifier
  arch_topology: Use CPUFREQ_CREATE_POLICY instead of CPUFREQ_NOTIFY
  thermal: cpu_cooling: Switch to QoS requests instead of cpufreq
    notifier
  powerpc: macintosh: Switch to QoS requests instead of cpufreq notifier
  cpufreq: powerpc_cbe: Switch to QoS requests instead of cpufreq
    notifier
  ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier
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

