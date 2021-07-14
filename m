Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F903C9351
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 23:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhGNVtS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhGNVtR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 17:49:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7AC061760
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jul 2021 14:46:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 8so6115299lfp.9
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jul 2021 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR/btbe504ikCrRzJGo5ktlDT0Nj2F4KipBhyP56FHQ=;
        b=052d8aolVEbgWlAhUTObQeSSSsc/5cyQRm4SrN6i3GbJklAnbh2nHkQX/SHxYOxxEZ
         lRTpL2lUyo+HvDqFCK9mMrheoMSkaT3Gd9zzB4HT0+0VOJrIVtSSJbLMbVrdpgP22GZH
         3FAYw4PVzXhVbRgprQhdyapFqXkJRQcVicAQ3bO+/um4TjUjB1EaXT9FkLLQL9rxpbcx
         LAyJ4yvOBhbqtWqkz7tMudXCDMXKoYCH6nI5ZwvAGhrJTZlYOuMExSzZsOa2NkkeCXXc
         ktJ/rFBabqFc7a5syDapOtp3GrcvkX2MQhccw6qAQXC7gD2/MgwL8OJVanG/XAf/5J6z
         59WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR/btbe504ikCrRzJGo5ktlDT0Nj2F4KipBhyP56FHQ=;
        b=uAhvMwegBJeADR/7LRsYKxOjhlUzMr1i9QM1NFzPqowRN1GmQ1vEiDkWT7O8NGIkXH
         1323IFMsFxrWgoU3ZEXBc5IiRBMTx9rrJCtTVl1RPjlWKOU0d+29rMuiCGKE2W6oUkwT
         e5dqG0E0oG4ypro3/ULismgtA/KlwfYEq/p+wgMMoTW7MQ3OpCzbAQhazuhjM6xUCSeZ
         4fGGzDh4Lo75D1YCSHrX8Wjrcb9NR9spFcdOzB/Buq2ZcyizN1cAxEQe/VBe9FGXWBqm
         krGmHBSZbHKdDswt5J5OwIn0hN3A/wlOk5rn/YpklEc0QKMNWERi3xr9fzO71lAOxXrl
         GmEA==
X-Gm-Message-State: AOAM5315rL7SiQ4omqZJn8dO3g1HkOVUF8oVBJfFdT8oQ+HCykcJxmw9
        EKw/44gvsplia4xWU8i9CxnMoQ==
X-Google-Smtp-Source: ABdhPJyrOWKbrcjB8a2SKmUBymUcYuceia/qvuLTjwUKPG8fXMmdLl3la6ni1sVQKMB4Y1uvp2FV6w==
X-Received: by 2002:a05:6512:158b:: with SMTP id bp11mr204118lfb.172.1626299183183;
        Wed, 14 Jul 2021 14:46:23 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id s21sm370837lji.57.2021.07.14.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:46:22 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 0/2] ACPI: Update DBG2 Serial Port Subtypes list
Date:   Wed, 14 Jul 2021 23:43:44 +0200
Message-Id: <20210714214346.1397942-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This short patchset adds support for the new 16550-compatible
serial port subtype in the spcr.c driver, using the definition from
updated ACPICA header.

I'm looking forward to the comments or remarks.

Best regards,
Marcin

Marcin Wojtas (2):
  ACPICA: Add new DBG2 Serial Port Subtypes
  ACPI: SPCR: Add support for the new 16550-compatible Serial Port
    Subtype

 include/acpi/actbl1.h | 15 ++++++++++++++-
 drivers/acpi/spcr.c   |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.29.0

