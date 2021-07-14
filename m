Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198793C9353
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhGNVtT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 17:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbhGNVtT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 17:49:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3882C06175F
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jul 2021 14:46:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v6so6143416lfp.6
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jul 2021 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lH52iQ89d3JdCw1yanWMdKAt6CiDTmROo7xBwGJBkCg=;
        b=NgWFUD3QKKcxsdDRCUmDEUk0IUlU+0aZxk181PRlYjy3+yp4sKxFeE2SHIQdRZRp7k
         yeDjlZt+T3LJO9mvxPhk+fyEISHQScsymlKCKXpCY6hWaPfmwlW6y/aO6I1HScGNzYEB
         dM/EcQ+2GyCPJKxxcG1QHM84dML02BbnhB+PqpfdPVuWTQgH05Z1ZOT0URsLXLu20l95
         iNdUfnE+sAlfnPT7RaAhmYtZhmUIHZNOcQOGQkPw+wTWiXbj8jEK4aJc6rgt5Yu0PEOi
         LYObgPue2y1HiWqD2fE09rH2oRfcx/NWk+N4RlT9qM3tv3KZ4dO0uIAOX6S0GHFvtDIM
         kXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lH52iQ89d3JdCw1yanWMdKAt6CiDTmROo7xBwGJBkCg=;
        b=jq1YK5FXCghZV8026awKMP9K+qAuTMjNTllCv8kkre43YxOqkB/DyGzXzLJ/xuGde4
         4guSe1towVztBumh9wlOOlN39urlRMtJ2nJRUjQe7M/rxrKD6h8BP8luf3Pavk48WWxy
         IVtv/xNKNHUVb7mK+9IyYwWPttLP1PNR1j0aN/hcNGFdk1nUEGUqYRz5CK7ikiq2r/HY
         9Bx7AYvRZHzARpEcgUXXinPRdeIGF/kgHykBczeZfZwDWBCT71iYktXGW3Pro9krNpkA
         kizf6A0GM8tLAcCDXnvl5oY5mCHtAy95fd1Mfhn0/SIXuKunlJ3Wk/7s2NgD9y+sJks4
         DPXw==
X-Gm-Message-State: AOAM530EZhbZBNpSzNzKACbNqbWX5398fPbep3qvCLL/YKhvDrvzMQoK
        VyA+rhsZX2KyF1x7kpjAc2Idmw==
X-Google-Smtp-Source: ABdhPJxthwLdCnryFxZ0ELE1D9Row/k0pt3HWvAqvkLVx29rmwps7QRVOmbjdXWaN/OZYocOukHVqw==
X-Received: by 2002:a19:6d01:: with SMTP id i1mr214902lfc.422.1626299185256;
        Wed, 14 Jul 2021 14:46:25 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id s21sm370837lji.57.2021.07.14.14.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:46:24 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 2/2] ACPI: SPCR: Add support for the new 16550-compatible Serial Port Subtype
Date:   Wed, 14 Jul 2021 23:43:46 +0200
Message-Id: <20210714214346.1397942-3-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210714214346.1397942-1-mw@semihalf.com>
References: <20210714214346.1397942-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Microsoft Debug Port Table 2 (DBG2) specification revision
May 31, 2017 added definition of the 16550-compatible Serial Port
Subtype with parameters defined in Generic Address Structure (GAS) [1]

Add its support in the SPCR table parsing routine.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/acpi/spcr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 88460bacd5ae..25c2d0be953e 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		break;
 	case ACPI_DBG2_16550_COMPATIBLE:
 	case ACPI_DBG2_16550_SUBSET:
+	case ACPI_DBG2_16550_WITH_GAS:
 		uart = "uart";
 		break;
 	default:
-- 
2.29.0

