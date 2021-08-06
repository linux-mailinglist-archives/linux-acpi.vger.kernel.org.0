Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E25A3E3181
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Aug 2021 00:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhHFWJd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhHFWJc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 18:09:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C16C0613CF;
        Fri,  6 Aug 2021 15:09:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h13so12817892wrp.1;
        Fri, 06 Aug 2021 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61uYc0ybuPZJsAg3poDyNnO4gGJo63dzsPVkw4zres8=;
        b=fej6Z2OHglbjlDSdOcHclg8rC/PokCBE/H+NC9J/bLNaJNluvTJCJlUsccEsxdZgOQ
         us7jxrRrUuwtIwBNy5DScJGZ49Cfohhu5Bv9j4FgAf/Q5BYLntEGvkXQuDqFwZcyDVyv
         k80Eb9eZAXq5fs7s6gZgsHmayHYXvhyii6/KzxbpGFF1L6C4Z2kND+GZAUb1TB7dsnCM
         +I0SlPSkWeoOFu7HU9MmxJDriMKbnNWYn0FFBaVQYX6H85WY1i8djYoiUnfXnSlrVzIw
         x0SM/uFFUWslKbNLKqhzkGNAszsnwwDE/8fiU5ciP3jPbLSE+R5P/gOeGptnBlUway+3
         EpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61uYc0ybuPZJsAg3poDyNnO4gGJo63dzsPVkw4zres8=;
        b=WTM4Kiwz+26RNWAvD2BrZyBqVsXox/J+y9r00/Ng+0+jzLqnvcJgdvVQwGBWfdR7Qj
         nofCH4+rIm1ylKJ6lk9hYap0xLwjmDYCS9PUypLfD2aYiWoUXqNJUP5vDKLua2YEDmKR
         Ua9BdDSXw2yyRGX2RkqGA8M99Bm1HMEyhWLDAHIaEnAifgI9fbkInDuV6VAfQcH9AXVs
         2nqo3Es+ucOwceYTAUBwe7oj38zdAfcQ3oYyTiH5prmLXyuh+mpRxqlPIHK4zO/DZebd
         HjpK43xF/VhSco0e3s6/4P3ff0MwmWm/9TxqOAFeqJ7dv7hM71bjoy0Tzq9CHBV5un/A
         UVDg==
X-Gm-Message-State: AOAM5336YXWRWqkKg5oNWp2M1Zy+YHe1X2Cc3SHxTK6/CrmELFnFJRwa
        2EetXL8liuUDNgfZ6Xa1paabxvaSmFI=
X-Google-Smtp-Source: ABdhPJxm3h3XgyIrEgSAaQ3T0/8+IP2TW9p8Y6ypHRppOX0HDaGCy+n59hDXaHxEvAvvlSxbw5nVtQ==
X-Received: by 2002:adf:ba0d:: with SMTP id o13mr12688879wrg.134.1628287754706;
        Fri, 06 Aug 2021 15:09:14 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id y21sm12764204wma.38.2021.08.06.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:09:13 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH RESEND v3 0/2] Check for endpoints in fwnode->secondary more sensibly
Date:   Fri,  6 Aug 2021 23:09:04 +0100
Message-Id: <20210806220906.326758-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all

A while ago I patched fwnode_graph_get_endpoint_by_id() to check for endpoints
against fwnode->secondary if none was found against the primary. It's actually
better to do this in fwnode_graph_get_next_endpoint() instead, since that
function is called by fwnode_graph_get_endpoint_by_id() and also directly called
in a bunch of other places (primarily sensor drivers checking that they have
endpoints connected during probe). This small series just adds the equivalent
functionality to fwnode_graph_get_next_endpoint() and reverts the earlier
commit.

Resending with +CC linux-acpi

Thanks
Dan


Daniel Scally (2):
  device property: Check fwnode->secondary in
    fwnode_graph_get_next_endpoint()
  Revert "media: device property: Call fwnode_graph_get_endpoint_by_id()
    for fwnode->secondary"

 drivers/base/property.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
2.25.1

