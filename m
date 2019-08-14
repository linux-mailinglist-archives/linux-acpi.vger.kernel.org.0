Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5354C8DFD1
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfHNVbY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:31:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42452 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHNVbY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 17:31:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so435796wrq.9
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 14:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYm0oLJfCUJDLfaw8xlKVmKmh5gb1gg5bZ8BsqpbG2w=;
        b=N2MO9Ph7eMeJ0zeeEGysl9ExxW1PUqnai2wGl8B6m/6xOhrFNVatTBgzB3Vmojt2Qb
         epcq2TVXCCiyKnyLum4sJ5kuZn/tyK+jlAqhX/EF1SPan6Ex29FnIY+y1T4bl2dXe7I1
         sQwDGI1/ZvHzTxHEjBp5pNYEsl/x+SS8uVaaxG2Oc0J3xNCDVqbtNTPDLLLGbXxMuByo
         KDvelb6bnQvr5o2NaU5Pl3DXSBs0H41BVBe+MIO9P+V4eIHBg/e+5aFbAZ91CRuJv6pt
         g1DGlGCE7ydYISKUFejFY9lK35FDq8LM5+ijiGM6+kCoKwMLSLsNo5+7+60CrCFobvr+
         hIyw==
X-Gm-Message-State: APjAAAUPOpuJRbwRRO43txamsls9CiDwgiY273FG6Uj2BY65w2WQSGfK
        /1l8wFbC3i4E1Vkzz74ww0m/mg==
X-Google-Smtp-Source: APXvYqw8lLuTxZ6hfwdZzJNnfdFn5XmLS+VVLFtxxRVv3rAphO1bdipm2Vg6J5p9FbEQHc8AEmYICA==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr1683889wrs.131.1565818282025;
        Wed, 14 Aug 2019 14:31:22 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:21 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 0/7] Adding a proper workaround for fixing RTD3 issues with Nouveau
Date:   Wed, 14 Aug 2019 23:31:11 +0200
Message-Id: <20190814213118.28473-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

First three patches are removing ACPI workarounds which should have never
landed.

The last four are adding a workaround to nouveau which seem to help quite
a lot with the RTD3 issues with Nouveau, so let's discuss and get wider
testing of those and see if there is any fallout or laptops where the
issues don't get fixed.

Karol Herbst (7):
  Revert "ACPI / OSI: Add OEM _OSI string to enable dGPU direct output"
  Revert "ACPI / OSI: Add OEM _OSI string to enable NVidia HDMI audio"
  Revert "ACPI / OSI: Add OEM _OSI strings to disable NVidia RTD3"
  drm/nouveau/pci: enable pcie link changes for pascal
  drm/nouveau/pci: add nvkm_pcie_get_speed
  drm/nouveau/pci: save the boot pcie link speed and restore it on fini
  drm/nouveau: abort runtime suspend if we hit an error

 drivers/acpi/osi.c                            | 24 ----------
 .../drm/nouveau/include/nvkm/core/device.h    |  2 +
 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  9 ++--
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  6 +++
 .../gpu/drm/nouveau/nvkm/subdev/clk/base.c    |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/base.c    |  9 +++-
 .../gpu/drm/nouveau/nvkm/subdev/pci/gk104.c   |  8 ++--
 .../gpu/drm/nouveau/nvkm/subdev/pci/gp100.c   | 10 ++++
 .../gpu/drm/nouveau/nvkm/subdev/pci/pcie.c    | 46 +++++++++++++++++--
 .../gpu/drm/nouveau/nvkm/subdev/pci/priv.h    |  7 +++
 10 files changed, 84 insertions(+), 39 deletions(-)

-- 
2.21.0

