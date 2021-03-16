Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8933DD42
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Mar 2021 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhCPTTF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Mar 2021 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbhCPTSv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2021 15:18:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A431C061762
        for <linux-acpi@vger.kernel.org>; Tue, 16 Mar 2021 12:18:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso2082985wmi.3
        for <linux-acpi@vger.kernel.org>; Tue, 16 Mar 2021 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdXuSq1MtFWEH67XusLrQERuO71IBN9bklER821sqN8=;
        b=s4NVtxjbXpVnGlId4ipIw5iTpHWbiL/Y/fXzzQ9WAq1M9jTjr8hJmD+u0Y1X2a7D0d
         TNJp1Pog2bUKGIxCsrUlpVLY9/HVfrn6QKfZ5Rj4Dxd8AMivBRKXlXbKHbZH+P0KWOEY
         Sz8nGP+cJLgyR6mklJnqesgsS47g9cq9EIn/j0AoAJ0tyTbGBn8q3JTouZH41Fz4gJBS
         4PpEoKbfSjoDSEnF4uqWL1STLzC5v6fT+VTAsTAD5fvQ15cdq1e6By6PtCjN91nYu6Br
         2s2gl2BgknygB1PCinbKXJKkw9Sj2iIn+K4I1gbzAWXN/bz+Hmn754PN3i9NmC8jkZlI
         2JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdXuSq1MtFWEH67XusLrQERuO71IBN9bklER821sqN8=;
        b=XfzQ25IC5w1Z5mJOe1y4um5kuMKSsqspBHCgfX72DXXzLnOjNlsaHALrZStswo8c34
         4xDHdJE/BagZKnU2B+TaKbD1KEOombu0rZNRsDw+5ko76JLiQuAMC7blvl1qPumVEDBF
         2yLEY9htb1inSyoa1+JMoHVTstXqA4XBfsFZtNIKkxCw80beOClh+cvQfuXp4SY9+WnD
         MiboDaMikopllB6AdATkM0mEwmUlNmxA1oHL6xxo4RXXQSLTILSYxw4wTB/GaSPrfCwV
         WTwgljvaSEYAGFwCe005jlJyaISG7sesYmLmh4G7kqFgYy7ClMa9/sENpYdqw/z5RbA6
         mhwQ==
X-Gm-Message-State: AOAM532ivxqW1+8ntGgQRj3PDIKv0iIs9+MyaSX+041ZKUn1k8Vk7OtZ
        MDBFzfcvObDk97YQkFvVgwWZuw==
X-Google-Smtp-Source: ABdhPJz0jcae/+Uzho0TthFbPf4pqfFt1iIHk4l3M0JPfNdoif7RmtFH7kwM8PaGGtYtJPuUlNO8uA==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr364692wmj.46.1615922318165;
        Tue, 16 Mar 2021 12:18:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p12sm22690438wrx.28.2021.03.16.12.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:18:37 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        jean-philippe@linaro.org
Subject: [PATCH 0/3] Add support for ACPI VIOT
Date:   Tue, 16 Mar 2021 20:16:50 +0100
Message-Id: <20210316191652.3401335-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a driver for the ACPI VIOT table, which enables virtio-iommu on
non-devicetree platforms, including x86. This series depends on the
ACPICA changes of patch 1, which will be included in next release [1]
and pulled into Linux.

The Virtual I/O Translation table (VIOT) describes the topology of
para-virtual I/O translation devices and the endpoints they manage.
It was recently approved for inclusion into the ACPI standard [2].
A provisional version of the specification can be found at [3].

After discussing non-devicetree support for virtio-iommu at length
[4][5][6] we concluded that it should use this new ACPI table. And for
platforms that don't implement either devicetree or ACPI, a structure
that uses roughly the same format [6] can be built into the device.

[1] https://github.com/acpica/acpica/pull/666
[2] https://lore.kernel.org/linux-iommu/20210218233943.GH702808@redhat.com/
[3] https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
[4] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
[5] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
[6] https://lore.kernel.org/linux-iommu/20200821131540.2801801-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (3):
  ACPICA: iASL: Add definitions for the VIOT table
  ACPI: Add driver for the VIOT table
  iommu/virtio: Enable x86 support

 drivers/acpi/Kconfig         |   3 +
 drivers/iommu/Kconfig        |   4 +-
 drivers/acpi/Makefile        |   2 +
 include/acpi/actbl3.h        |  67 ++++++
 include/linux/acpi_viot.h    |  26 +++
 drivers/acpi/bus.c           |   2 +
 drivers/acpi/scan.c          |   6 +
 drivers/acpi/viot.c          | 406 +++++++++++++++++++++++++++++++++++
 drivers/iommu/virtio-iommu.c |   3 +
 MAINTAINERS                  |   8 +
 10 files changed, 526 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/viot.c

-- 
2.30.2

