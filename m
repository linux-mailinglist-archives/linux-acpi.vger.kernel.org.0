Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5961B51B575
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiEECBy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 22:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiEECBy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 22:01:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289FE4C787;
        Wed,  4 May 2022 18:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715896; x=1683251896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPStXkvr3rZk2D9ys9NDAfJduNmQmCY//XhY19dRqT0=;
  b=kEpWLvXPitb5JAg2LPrmo7qOkDOIFthUj7tGlOOramfLbftEvAjw9awz
   KsWoJ4eR0qS/2kw3IPgmvjuVelIuJ8XIKLFNHDjseZE708v5ep2wuC7y/
   AoMrtGJPp61KWntQf1ri3sPI8Me8vIqdWbGoYcLX2fqXbOLupmDZxTYsN
   Jq/+jv0ZlBBcPkB4YCUZojGWFYxToNSYnqUUdlLKJM4jItTZwq+i0Yr/S
   v/l9+FIxoQ5/5tvF0DfK2bfLrr/oVmU/yVCj3sVG5Lvbl79LOs+XaEXTK
   3bMZvmAkwIwx3yd2UvR9F58ShcDNWELfJ+VazwtNLKB018d2euO0GmTii
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293153400"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293153400"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537105971"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:58:12 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, kvalo@kernel.org, alexandre.belloni@bootlin.com
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH 0/7] PM: Solution for S0ix failure caused by PCH overheating
Date:   Thu,  5 May 2022 09:58:07 +0800
Message-Id: <20220505015814.3727692-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some Intel client platforms like SKL/KBL/CNL/CML, there is a
PCH thermal sensor that monitors the PCH temperature and blocks the system
from entering S0ix in case it overheats.

Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
temperature above threshold") introduces a delay loop to cool the
temperature down for this purpose.

However, in practice, we found that the time it takes to cool the PCH down
below threshold highly depends on the initial PCH temperature when the
delay starts, as well as the ambient temperature.

For example, on a Dell XPS 9360 laptop, the problem can be triggered 
1. when it is suspended with heavy workload running.
or
2. when it is moved from New Hampshire to Florida.

In these cases, the 1 second delay is not sufficient. As a result, the
system stays in a shallower power state like PCx instead of S0ix, and
drains the battery power, without user' notice.

In this patch series, we first fix the problem in patch 1/7 ~ 3/7, by
1. expand the default overall cooling delay timeout to 60 seconds.
2. make sure the temperature is below threshold rather than equal to it.
3. move the delay to .suspend_noirq phase instead, in order to
   a) do the cooling when the system is in a more quiescent state
   b) be aware of wakeup events during the long delay, because some wakeup
      events (ACPI Power button Press, USB mouse, etc) become valid only
      in .suspend_noirq phase and later.

However, this potential long delay introduces a problem to our suspend
stress automation test, because the delay makes it hard to predict how
much time it takes to suspend the system.
As we want to do as much suspend iterations as possible in limited time,
setting a 60+ seconds rtc alarm for suspend which usually takes shorter
than 1 second is far beyond overkill.

Thus, in patch 4/7 ~ 7/7, a rtc driver hook is introduced, which cancels
the armed rtc alarm in the beginning of suspend and then rearm the rtc
alarm with a short interval (say, 2 second) right before system suspended.

By running
 # echo 2 > /sys/module/rtc_cmos/parameters/rtc_wake_override_sec
before suspend, the system can be resumed by RTC alarm right after it is
suspended, no matter how much time the suspend really takes.

This patch series has been tested on the same Dell XPS 9360 laptop and
S0ix is 100% achieved across 1000+ s2idle iterations.

thanks,
rui
