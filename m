Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6ACC10C6A3
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2019 11:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfK1K2e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Nov 2019 05:28:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33596 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfK1K2e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Nov 2019 05:28:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id y206so4315477pfb.0
        for <linux-acpi@vger.kernel.org>; Thu, 28 Nov 2019 02:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=B3lxw588eEWcnFb1kiTs24kLoa25nUsoz4s4TuTklFU=;
        b=Kbc/zqhdwRPFMePq1e6q6XDWexTeBlNb1uTQeQFAddFFjFQF4pFgOTSK6LMKZ9LmSt
         zi2qHCygMst2ChSczuPcNbtY3EankPqVeTSIEHWe1b67FXi+ioB3/9h3ZAQ0kMC/naC3
         bAwQ83aUiSgmzfjceaGwzan6z5Q1lCxtfvm8iR0UQHHOmvUV+yjHy7Aoc4Krsr67sV1x
         jFl6HhmYG8SBEWphGgOzpWYuaCGLc/KzZa10wRokqUUX8Oy0No/yPLe1DtDAxTPuwhUU
         keiKNqFfH+Yg8jPSc8PG2bSJnKPyBU/Tfa7rq42iPBPTYkU3xANlPBqjAkMKdyXt8bT6
         8WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=B3lxw588eEWcnFb1kiTs24kLoa25nUsoz4s4TuTklFU=;
        b=K6BJ7XvIm3LPMf/2NG44hWZPVUkKxab6aIjseFNlx5tGPX941Jm6E1MqvYd9J8Oqtt
         n6wIMRBgfeNdtsWi9RNNXiZK8QSQMLnpgcWl72YkEvsekfwCvNqI/crdJJSWa5kQpzue
         ObLDJ1B/GC2qA0Uv0WsMJ3KMGkeuKem4jiIYjJawIMeiyP+V0MidV4UYISYDiLGlkZeB
         vhu40ktCEJScpRVvVo75c2/gijbyhkKUGSkgONkZt2HIrep0hG0CldEVwC6J7KFKxaTe
         fCIuPd2T7on7iqFjvAZQUlc998mZuqZrGVg0QBaKldzHNwOOlwNFl1lmy+MB6m+fDBXf
         1Q9g==
X-Gm-Message-State: APjAAAXNpsP84UZSbNyjnnFXZxlpfExsuR/mXWcsLNo5infcQLPRWwTT
        RHHj5gYJRW0crJ/Ns5y5RkU=
X-Google-Smtp-Source: APXvYqy3zza4nZXXclF814+WAXI8lqp7E5eiMIZ3ZE9qaMhtdkQzLkSDyHADwyFfGGU8ktpnTqeofg==
X-Received: by 2002:a63:474a:: with SMTP id w10mr10299491pgk.331.1574936913809;
        Thu, 28 Nov 2019 02:28:33 -0800 (PST)
Received: from cosmos ([122.172.20.170])
        by smtp.gmail.com with ESMTPSA id v128sm19708721pgv.24.2019.11.28.02.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 02:28:33 -0800 (PST)
Date:   Thu, 28 Nov 2019 15:58:29 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: fix for memory leak in i2c_acpi_install_space_handler
Message-ID: <20191128102825.GA1774@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

kmemleak reported backtrace:
    [<bbee0454>] kmem_cache_alloc_trace+0x128/0x260
    [<6677f215>] i2c_acpi_install_space_handler+0x4b/0xe0
    [<1180f4fc>] i2c_register_adapter+0x186/0x400
    [<6083baf7>] i2c_add_adapter+0x4e/0x70
    [<a3ddf966>] intel_gmbus_setup+0x1a2/0x2c0 [i915]
    [<84cb69ae>] i915_driver_probe+0x8d8/0x13a0 [i915]
    [<81911d4b>] i915_pci_probe+0x48/0x160 [i915]
    [<4b159af1>] pci_device_probe+0xdc/0x160
    [<b3c64704>] really_probe+0x1ee/0x450
    [<bc029f5a>] driver_probe_device+0x142/0x1b0
    [<d8829d20>] device_driver_attach+0x49/0x50
    [<de71f045>] __driver_attach+0xc9/0x150
    [<df33ac83>] bus_for_each_dev+0x56/0xa0
    [<80089bba>] driver_attach+0x19/0x20
    [<cc73f583>] bus_add_driver+0x177/0x220
    [<7b29d8c7>] driver_register+0x56/0xf0
In i2c_acpi_remove_space_handler function, leak occurs whenever "data"
parameter is initialized to 0 in call to acpi_bus_get_private_data().
This is because the parameter validity check in acpi_bus_get_private_data
(condition->if(!*data)) returns EINVAL and as a consequence, memory is
never freed in i2c_acpi_remove_space_handler function. Fix/Correct the
parameter validity check in acpi_bus_get_private_data() as that of
similarly done in acpi_get_data_full().

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 48bc96d..5400267 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -153,7 +153,7 @@ int acpi_bus_get_private_data(acpi_handle handle, void **data)
 {
 	acpi_status status;
 
-	if (!*data)
+	if (!data)
 		return -EINVAL;
 
 	status = acpi_get_data(handle, acpi_bus_private_data_handler, data);
-- 
2.7.4

