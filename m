Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E901D292F1B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 22:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgJSUFD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 16:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbgJSUFC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 16:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603137901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=mnoRDcLRpk47e6nhzTgs1K3yhuyBi+7gPd1VRJKtnrw=;
        b=CGzEAYnPSNTbr521XYiMy3YYeYXbQ/a4Ln9CtyPUPbgxIShj82Xv8LlQeDn9PaSGsIktu2
        qwNGE96SOLbjJSvw1uRgH4XjBj4oxuMhEMrXNUBspZaZuccp94e1ppSVz6paSKC+Wy56lp
        lBppqamogTy9v2AXTgYBIgTRGSmLVUo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-RnyE62ScNEa6Q-Hl-j3byw-1; Mon, 19 Oct 2020 16:04:59 -0400
X-MC-Unique: RnyE62ScNEa6Q-Hl-j3byw-1
Received: by mail-qk1-f200.google.com with SMTP id j185so570391qkf.7
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2020 13:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mnoRDcLRpk47e6nhzTgs1K3yhuyBi+7gPd1VRJKtnrw=;
        b=RuffGmaNx+k3XgDER/qAgv+ydLWsR/B4GSns5u+unXhXRwwLUkujy59h2c1VXEXQn6
         s5cF9E3Q9uGd823t3RGgMxNcunbklRpJJKgzNWo5uuoogV3ouS3l3xRa8eQciLr5aTiV
         nKBipSvTlKDvxV+ApmxG9CiXAZ2CLEM+uuk2tMueZUsR+4VSIxMTOjidHW4F09fhITal
         yhnY6Lwj+LijZIHeQ25Uff7RYOtqTG7b9UGn4kNhIpJG5WeicdpQJdyPtuiKYZWbtnfG
         Z5teb5PYXeyeR+0qWRB0bcT/b41qbWweQ4684Z6DzfX86xIlEHeyR/YYLNltU1KPezHS
         Mmtg==
X-Gm-Message-State: AOAM530aru+9Z/FFJ5KU0jaqhEzYND6P+AmN1nrjjfht5+eU2mOyfYQH
        fpAbf7jnRYycKMBU30GQN4Wwo5bW6RVPIGLggSelvxEhpPoHeRHfAHukEzbugejsTYVBW/o07kr
        Alp18x6rrD/qFTQjcLobg3w==
X-Received: by 2002:a0c:a166:: with SMTP id d93mr1542688qva.22.1603137899183;
        Mon, 19 Oct 2020 13:04:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsbpFpfbLblIlcs3o3CaAmJ42DgOJ5oXwzID77rU+/hVJK0TWsSYMpdjqWTgD/b7WK/kOHmg==
X-Received: by 2002:a0c:a166:: with SMTP id d93mr1542670qva.22.1603137898939;
        Mon, 19 Oct 2020 13:04:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 128sm454249qkm.76.2020.10.19.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:04:58 -0700 (PDT)
From:   trix@redhat.com
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] acpi: utils: remove unneeded break
Date:   Mon, 19 Oct 2020 13:04:53 -0700
Message-Id: <20201019200453.16864-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 838b719ec7ce..d5411a166685 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -104,7 +104,6 @@ acpi_extract_package(union acpi_object *package,
 					      " [%c]\n",
 					      i, format_string[i]);
 				return AE_BAD_DATA;
-				break;
 			}
 			break;
 
@@ -129,7 +128,6 @@ acpi_extract_package(union acpi_object *package,
 					      " expecting [%c]\n",
 					      i, format_string[i]);
 				return AE_BAD_DATA;
-				break;
 			}
 			break;
 		case ACPI_TYPE_LOCAL_REFERENCE:
@@ -144,7 +142,6 @@ acpi_extract_package(union acpi_object *package,
 					      " expecting [%c]\n",
 					      i, format_string[i]);
 				return AE_BAD_DATA;
-				break;
 			}
 			break;
 
@@ -155,7 +152,6 @@ acpi_extract_package(union acpi_object *package,
 					  i));
 			/* TBD: handle nested packages... */
 			return AE_SUPPORT;
-			break;
 		}
 	}
 
-- 
2.18.1

