Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9D1A273
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfEJRhi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 13:37:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:17666 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJRhi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 13:37:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 10:37:38 -0700
X-ExtLoop1: 1
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2019 10:37:38 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 0/2] ACPICA release 20190509
Date:   Fri, 10 May 2019 10:25:41 -0700
Message-Id: <20190510172543.9831-1-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is the linuxized version of the ACPICA 20190509 release. This
release contained almost entirely iASL compiler features and bug fixes.
For linux, this release contains a simple adjustment to move
ACPI_DEBUG_DEFAULT symbol out of an ifdef.

This patch set is also available at the following link:

https://github.com/SchmErik/linux/tree/acpica201905

Bob Moore (1):
  ACPICA: Update version to 20190509

Erik Schmauss (1):
  ACPICA: Linux: move ACPI_DEBUG_DEFAULT flag out of ifndef

 include/acpi/acpixf.h           |  2 +-
 include/acpi/platform/aclinux.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.2

