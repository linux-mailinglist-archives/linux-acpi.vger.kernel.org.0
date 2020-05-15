Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63151D4544
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 07:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEOFfF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 01:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726240AbgEOFfF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 May 2020 01:35:05 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1F6C05BD09
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 22:35:04 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i17so1110823qka.4
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qx5/VgfsCB/0k5IE7hJvg2xd2TLeiyTwpbJCbmIdWvI=;
        b=lvHWU6VeXu6KapJJkibDasYRuW+k6b/OfIy63ABvf5/06XyVIw7icDWGXVSOOkM7hL
         S6vwzrEjQQEtfi6SNZkmBp11uUzyJCuP7CWjecdBDIck4uWCgF9P8NCf4jItObYNDeP7
         g04ubuy4+WgB0GMQXY1aKTDPvv+xtoysuQbwRn9O9BYtEKx901rHzXNSgdfuYjxBRIGV
         5JG1us+oGljF3deg6Hx8SJi81zFbyc/RjO/ZKsL28wGWlZoYqlU85740UsvcADKZk/zz
         evtsHRbTQ9QBny9Svq/nHXX9ZqhL2HBKyrnBxBuQrTEcjoHjCpYZuiD4AkiUSMpc6zd+
         +hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qx5/VgfsCB/0k5IE7hJvg2xd2TLeiyTwpbJCbmIdWvI=;
        b=KQyjqaX/QCMNo6ug5Pi6OgGHB0V3LeXnluOA9Tp7jDmyiI8wGhuyGbLRF0ki4n/OBf
         uRjfF1wF5mgDJOIPtmx3YqL1LPqp9jGOQnFnE5ftRzJrDv5is+qXQNLjTnYujVtMM8pY
         KTjETY0hrJBBj7Hml4T1azwcCeTio5glz54YYagg1WoKXI4AZTIFE8R/m5WT4p2/UJzG
         ivdkr00BFknHuxI8OFRXrpRRCG2INviHpVtzu+29UK168xT7ECWeHVQ5PhB1wS/B9kaQ
         7VPZY2smqMFNxs+TTtoGBxmj42MSgTLUhRNs/tNPu7wkCFnj4JtzVvsDQVoFcCBbaZ0o
         F7fg==
X-Gm-Message-State: AOAM531Nmkd7n06dpgVMr/oGodPB59SdLvtLqefORozmp64EHJYlJmSO
        FiFSMTM9AoVEAm6fKP5mKzTzswX/qQx9zvY=
X-Google-Smtp-Source: ABdhPJzkZ7NwIirUL48KLBVkTRpO1s4i8GVWXAgGGRuJllEo33MlBuGiIXJOZt5DKrCCh2wbIIR0gtSAnJblP6g=
X-Received: by 2002:ad4:4c4f:: with SMTP id cs15mr1776465qvb.117.1589520903895;
 Thu, 14 May 2020 22:35:03 -0700 (PDT)
Date:   Thu, 14 May 2020 22:34:56 -0700
Message-Id: <20200515053500.215929-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1 0/4] Optimize fw_devlink parsing
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ji Luo <ji.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When fw_devlink is enabled on hardware with a large number of device
tree nodes, the initial device addition done in
of_platform_default_populate_init() can be very inefficient. This is
because most devices will fail to find all their suppliers when they are
added and will keep trying to parse their device tree nodes and link to
any newly added devices

This was an item on my TODO list that I'm finally getting around to. On
hardware I'm testing on, this saved 1.216 _seconds_!  Another SoC vendor
was also able to test a similar but hacky patch series and confirmed
that it saved them around 1 second.

Thanks,
Saravana
P.S: It took me longer to write the comments than the code!

Saravana Kannan (4):
  driver core: Move code to the right part of the file
  driver core: Look for waiting consumers only for a fwnode's primary
    device
  driver core: fw_devlink: Add support for batching fwnode parsing
  of: platform: Batch fwnode parsing when adding all top level devices

 drivers/base/base.h    |   1 +
 drivers/base/core.c    | 193 ++++++++++++++++++++++++++++++++---------
 drivers/base/dd.c      |   8 ++
 drivers/of/platform.c  |   2 +
 include/linux/fwnode.h |   2 +
 5 files changed, 164 insertions(+), 42 deletions(-)

-- 
2.26.2.761.g0e0b3e54be-goog

