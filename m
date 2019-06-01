Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D435B32122
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jun 2019 01:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFAXWK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Jun 2019 19:22:10 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:41572 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfFAXWJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Jun 2019 19:22:09 -0400
Received: by mail-pf1-f176.google.com with SMTP id q17so8388624pfq.8;
        Sat, 01 Jun 2019 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bytKcnWl4DSJZnnGOOS5hiwowoQ6gtqAZ+8TrBMmas8=;
        b=ZC4jPopia8riIAqC1pgw5kEc01ub5mspwVB4Wf3Lem5hJFgX7C2IaSVuItB4rkvBFT
         O6vieJpn45PAjYgsVkhTXsMKKDo2TXq3kk78iOLbBE0Uqm41+kwIABYx4B6rQ7+4qx37
         7XtcJL2CbMRfhODKsBOUCEH/nu1tCg9uwW9dAc9OeLSaMpy99vJlqVkujbmCHu1VbokQ
         oHMlkjIEw7lQ4lHL6+IKQ9Q/lp42SEgQNjxiXPRZ+7oVVk4Tdj2jAEXnPq3dU1FpeC0G
         crvBTnLRKHv9MDnYowazgTg2MzzIrp2y2bdYNwUruyuMaBmojPGJ30x75QsVYdZ5Tj4a
         GrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bytKcnWl4DSJZnnGOOS5hiwowoQ6gtqAZ+8TrBMmas8=;
        b=Xuy4eZabAAqnF76SgVnbLPHEci5TWqktboiGTNR9IC+9ChiTnPLmETnKgq/uF8Vy12
         reG5i7UUMHaO6YO0c1H+IcLNaw2Bn3rGlg27PY/J/rpg2XsMqdfCvEYJsRKr65sH+GRc
         bIV6OmDNrEv6IZM43PE3nV36jyHJ3NDneuaRRp+DCxF24Sb5DUJQXy7EQqKOPKY9yPJ4
         Gjb9TSOwBnl0i57OR/ldPV2lFYEKNumoP3j65GvriwMx1zWRl7Ln639g490Yxa+OTiCN
         EwlBRcMB0dP5cJjM9+Q/UL+hNx039KQZ6ivHvS328TBMdjKXiFNU45jTjXUpdx5Mq9hq
         Ve4w==
X-Gm-Message-State: APjAAAV8BfWZJvZziKU6AzdVK5yCdrZvo/TRhXu2tlmbHj16VntDngJt
        6NsAYsWGIYtCTbjp8UukZiY=
X-Google-Smtp-Source: APXvYqzoTrBsH3BR/eGzCZRW716vfkLIpcpbeen0ltSFQHkpgNlujb9zzby+KtzWvu1c+cEVCiMFbQ==
X-Received: by 2002:a63:1e5b:: with SMTP id p27mr19021226pgm.213.1559431328871;
        Sat, 01 Jun 2019 16:22:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id q10sm10112262pff.132.2019.06.01.16.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 16:22:08 -0700 (PDT)
Date:   Sat, 1 Jun 2019 16:22:06 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management fixes for v5.2-rc3
Message-ID: <20190601232205.GA7411@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Please consider the following thermal soc changes for v5.2-rc3. This is really
a single revert, detected to cause issues on the tsens driver.

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to ca657468a0d4bcc25445f6636485a19a525267bd:

  Revert "drivers: thermal: tsens: Add new operation to check if a sensor is enabled" (2019-05-28 19:30:33 -0700)

Specifics:
- Revert tsens change that is reported to cause issues.

BR,

----------------------------------------------------------------
Eduardo Valentin (1):
      Revert "drivers: thermal: tsens: Add new operation to check if a sensor is enabled"

 drivers/thermal/qcom/tsens-common.c | 14 --------------
 drivers/thermal/qcom/tsens-v0_1.c   |  1 -
 drivers/thermal/qcom/tsens-v2.c     |  1 -
 drivers/thermal/qcom/tsens.c        |  5 -----
 drivers/thermal/qcom/tsens.h        |  1 -
 5 files changed, 22 deletions(-)
