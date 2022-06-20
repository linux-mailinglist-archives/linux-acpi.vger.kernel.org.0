Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562C2552044
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jun 2022 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbiFTPMj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbiFTPMO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 11:12:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D32DFD
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 08:02:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a11so3446818ljb.5
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDW0iKUe4rl0AxxyRpSUfzqnbvrj0hO4TPTr9mwh6kI=;
        b=FEg3yuw9zuj0apotExwlLW1q5suVP6iGt/1G6WRjuwHmcCvuxI1Tsf0SZ2F8Cn+q2t
         mx4RPLR22FvnM7Q+zZurckshwY6mIap7dqn2mGeElD5DaJdpjkZT/WFzsUjq7GGitpBT
         YB3asvifr/wTkfhr0F6EFymDcrS9lx+famqRA53ZoPQJDNrECye82zNCvZ/ifwz2S+uV
         1Z8u/fhSkEBWPMruUTO5XOWnFFrcYbR6EaVbuu8zAPTJdP/2CxT8AiliZoFLiBoCuWDG
         0It84USVCUeZopmhbdIUswnZvu25VRiydCuJ2tNC1BfVu1ScHheK7q3/OsO65eqXy8h2
         MEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDW0iKUe4rl0AxxyRpSUfzqnbvrj0hO4TPTr9mwh6kI=;
        b=nmi4uJiwJJrOnnapubwDwUHhWNRMc8JSloCH8aoyvfvQ2zRUbrFFEXhhJ74H52ti8Q
         BjXl1RsxD9nSq9I+uDvIK3IYqyUnQ5c9r4VMN5vj3iniUVN25WHl03qhm+1UP4ntMtp5
         56Q3CRZKN4hhg9rDAETRlrmgjtGOI5eLPalw3KsUNnuM9sE6pUlw1T3+WpbjhtLcSFij
         I1Xr8bCEuwux7c5RoeeEdoDdp+QIGgYlXf5zLNFhLtYzSb3fwvHj2zMVSEBDiV4vMa54
         1EdUXQaN1StmfXyY0V81ntCAYOAunn94gAgyxegRfLijjWHSzNDxynYgqE0s7bTCAp88
         rVXg==
X-Gm-Message-State: AJIora9GYJfkU9hSOmyJ0B0LduOneE9Xc72Yt44iR8FrGY4v2uDwShDN
        2oz3QgBCzZacruPgukY8IgeEsA==
X-Google-Smtp-Source: AGRyM1tbm7QFG8lIJaukpRbduMFt0tpvrn9FXfCi0u/0W1N99p3BoT6LfGzkkKNb1ZzphlH4rxS4ug==
X-Received: by 2002:a2e:b0ce:0:b0:25a:6ad3:1ee7 with SMTP id g14-20020a2eb0ce000000b0025a6ad31ee7mr3842974ljl.1.1655737373671;
        Mon, 20 Jun 2022 08:02:53 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id e19-20020a05651236d300b0047f79f7758asm17564lfs.22.2022.06.20.08.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:02:53 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, hkallweit1@gmail.com, gjb@semihalf.com,
        mw@semihalf.com, jaz@semihalf.com, tn@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, upstream@semihalf.com
Subject: [net-next: PATCH 08/12] ACPI: scan: prevent double enumeration of MDIO bus children
Date:   Mon, 20 Jun 2022 17:02:21 +0200
Message-Id: <20220620150225.1307946-9-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220620150225.1307946-1-mw@semihalf.com>
References: <20220620150225.1307946-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The MDIO bus is responsible for probing and registering its respective
children, such as PHYs or other kind of devices.

It is required that ACPI scan code should not enumerate such
devices, leaving this task for the generic MDIO bus routines,
which are initiated by the controller driver.

This patch prevents unwanted enumeration of the devices by setting
'enumeration_by_parent' flag, depending on whether their parent
device is a member of a known list of MDIO controllers. For now,
the Marvell MDIO controllers' IDs are added.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/acpi/scan.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 762b61f67e6c..d703c35dc218 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1716,6 +1716,18 @@ static bool acpi_is_indirect_io_slave(struct acpi_device *device)
 	return parent && !acpi_match_device_ids(parent, indirect_io_hosts);
 }
 
+static bool acpi_is_mdio_child(struct acpi_device *device)
+{
+	struct acpi_device *parent = device->parent;
+	static const struct acpi_device_id mdio_controllers[] = {
+		{"MRVL0100", 0},
+		{"MRVL0101", 0},
+		{}
+	};
+
+	return parent && !acpi_match_device_ids(parent, mdio_controllers);
+}
+
 static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 {
 	struct list_head resource_list;
@@ -1756,6 +1768,9 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	if (acpi_is_indirect_io_slave(device))
 		return true;
 
+	if (acpi_is_mdio_child(device))
+		return true;
+
 	/* Macs use device properties in lieu of _CRS resources */
 	if (x86_apple_machine &&
 	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
-- 
2.29.0

