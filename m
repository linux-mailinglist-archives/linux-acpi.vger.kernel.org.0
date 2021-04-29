Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923BA36E3D6
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Apr 2021 06:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhD2DpA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 23:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhD2DpA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 23:45:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A2EC06138B
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 20:44:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b15so917646pfl.4
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwa/pNGEH72SdQ3b68tRDSHinWBotoIu0k9oNPS9WWU=;
        b=JUmaG+/PJiCYDuY7HLIJ1nvg/8afct8fPvNUCd1avtwC69dTUTqujZhaCIBVIDcOTZ
         UqgMD6stF5vJFTG6l/qWsD1UULx4L0pLBo/AvXoxfSSO4zlgDXwK5x+XbhZx2z4pDjrF
         0qNhiANa50D6yHcd4j3CxFmiTxob9DgyPbzagtReDU/+jV0HYERqS77EsOzVpjvbRFSR
         oXWY8vTbhQYga7vlZbA1rKLtjMGVAi3i9XWKt6dvf4FdWt64zDbWzLaXv6t0Z6OZK+qH
         b0Xu7QdTufRnbDJwvEVOiNcdO6O9tKsAebqcHvHfIBUJbSm7EFcZf7D3QyMLzyFO+KB3
         h4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwa/pNGEH72SdQ3b68tRDSHinWBotoIu0k9oNPS9WWU=;
        b=NM1K7sA8g1zqNjGOScdH5YfoZ47fH6cx6JxdQILG/OXoQDHtPMnC1SPTh7cQpbHYmN
         Tv58QEkBIPEEHDT5LR9o9BHutqi8PefQqEHQwHzcmjcaYGBkjg2XqPlk/o5xFPr2kHlK
         sgjhuEFEIIcVf6gEFmvTUuiC7ShbmK+wlP+r5gr6gT1bamR2er3rTciVTgKFnaI+ellL
         Lu6mUGe/B3XJKWLZ9YT9+qNggEM+BzfbKuQAY6/S3SutYh3OXaG4ElWeeHqsWtuqa2Tp
         71/mNMHhzwzi9frcEF1siizOxUy607tQBeR7V3DekSp+UbQn0TdWAF+xruE6HwAsRtL0
         FQgg==
X-Gm-Message-State: AOAM532UKLx9eNXZ0jlwYziPDqX4u6EuY3c8Ol8/H7GJG59EowL+xfY0
        NXVuW3rUUg/7Zr/W3LFXgvL3KOT/FZq8mnsj
X-Google-Smtp-Source: ABdhPJw5IDyUYyuxDcARiwTZjT4WpY9lZBBZfx7KLBVVxOCw9aOq6JLpQYK1XPPk44zgmMk89S4dYg==
X-Received: by 2002:a65:47cc:: with SMTP id f12mr7218672pgs.252.1619667853925;
        Wed, 28 Apr 2021 20:44:13 -0700 (PDT)
Received: from localhost.localdomain ([198.148.102.224])
        by smtp.gmail.com with ESMTPSA id nh10sm777219pjb.49.2021.04.28.20.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 20:44:13 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     hdegoede@redhat.com
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Subject: Re: [PATCH] ACPI: scan: Defer enumeration of devices with _DEP lists
Date:   Thu, 29 Apr 2021 11:43:58 +0800
Message-Id: <20210429034358.676-1-youling257@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
References: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

linux 5.11 rc1 "ACPI: scan: Defer enumeration of devices with _DEP lists" cause my v891w z3735f tablet boot failed, there is only one cursor in the upper left corner.
linux 5.11 rc5 "ACPI: scan: Make acpi_bus_get_device() clear return pointer on error" fixed this problem.
