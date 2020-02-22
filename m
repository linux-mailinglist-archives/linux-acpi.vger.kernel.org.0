Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9F168B9E
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2020 02:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgBVBko (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Feb 2020 20:40:44 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45536 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbgBVBkn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Feb 2020 20:40:43 -0500
Received: by mail-pf1-f201.google.com with SMTP id x21so2339667pfp.12
        for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2020 17:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0Alq4aXp7YzXN+AKMP8eBqRG3yPiXOJvC1/VEWq2Syo=;
        b=e7OPKG2KhyChpWNNR4nLuUXy4ylVfjqLMB0INuqTgORVMt4c48EOCa1hX7f0vVumGV
         Fl12/3GISHBbAZ97RhHkmzUnwcBemFYtUitr0VJcMtjeqpFxtUVOKyNmvgs7bmfVKCbC
         9KOa3O/uxq9/bSScNcxqwFUIBpU2Dk0Nevxnjbwq9NYDFPNPFYF82PBcwjVPtHAObGCy
         sX4eERpRAQDnlpBKSFC417QE5MtuCxGl+zr+heynrIeikegYLZAfZTNmhbZ6hDclGTgx
         8TJ0QSLqeS/71knXjOGDITkEFZxZSlCB7KHiB1MAYy/cR/WtHU8JCG1hUSQ9PupLWjLG
         63IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0Alq4aXp7YzXN+AKMP8eBqRG3yPiXOJvC1/VEWq2Syo=;
        b=Aj0AKN/k3D4EHxzKDx0iysvQXdf66kG0aYtjinfqwCvk8vO884boqdbSM8yzo1eQRg
         rxD2nZqsqTjr0JZ5U4pBFsFXcf6P7POxuMWuE8TT0eYjnVrF2Cx+J9IGXtzG4ZoEegGT
         N4XQJjgN0YmsGKi7Bnx5AOr5V7fIUT19/5w+vGdzdBRLTH3UN2jxdsgQZ1rDIZoowzy3
         R8WM6QJszkHspXLuaBz7WGkYbn0CoOeuX0gZQOnc1jfhwLepJMGx3TijyrI8LyBitHV6
         3Y29X2H0THQ3uwVovJ5Mr0821wJiC2B6I9JkF7e3D998myHO8MH4xHXSMgoWVu16Znq/
         cqRw==
X-Gm-Message-State: APjAAAXD16e46lQ1GGxM40yV/jbeMKFeLHnNsj8938hgpb7tSzMFnHjh
        VIuKzTyY/QgUqddtShCxiefaga8IXPAT4lw=
X-Google-Smtp-Source: APXvYqxW9MycS0KQIN3NTm0UDrGeNfKtCCiDECg2Y+zwfxgcfOoFsWcvFC2gpjKZaciSFlbJG9dbBDG/OdhB4VY=
X-Received: by 2002:a63:2a13:: with SMTP id q19mr22138542pgq.82.1582335642711;
 Fri, 21 Feb 2020 17:40:42 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:40:33 -0800
Message-Id: <20200222014038.180923-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 0/5] Add fw_devlink kernel commandline option
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

1/5 isn't really related to adding fw_devlink, but I'm just rolling it
into this series.

The rest of the series is about adding fw_devlink kernel commandline
that can be set to off|permissive|on|rpm which are in increasing order
of enforcement by device links.

2/5 is the most "interesting" part.

The hope is that once this series merges, we'll consider enabling
fw_devlink=permissive by default and at a later point in time ideally
"on".

Thanks,
Saravana

Saravana Kannan (5):
  driver core: Reevaluate dev->links.need_for_probe as suppliers are
    added
  driver core: Add fw_devlink kernel commandline option
  efi/arm: Start using fw_devlink_get_flags()
  of: property: Start using fw_devlink_get_flags()
  of: property: Delete of_devlink kernel commandline option

 .../admin-guide/kernel-parameters.txt         | 24 +++++++++----
 drivers/base/core.c                           | 35 +++++++++++++++++--
 drivers/firmware/efi/arm-init.c               |  2 +-
 drivers/of/property.c                         |  8 +----
 include/linux/fwnode.h                        |  2 ++
 5 files changed, 54 insertions(+), 17 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

