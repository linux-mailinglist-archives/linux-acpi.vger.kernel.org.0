Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE97F3CA7
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKHASI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:18:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHASI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:18:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so3556966pfn.4;
        Thu, 07 Nov 2019 16:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5uDsHtEnAyV8LSXcbH33x3kolR6+Pd+L+XI2h0ZELA=;
        b=JRNakx9yETLweznBgCj2Te6iCoo7Yk7x9osXt0sKe+QG7XBEGDFOMgjMuq662AM38W
         WYIau2/vV1hgThm6474EWPVfcy1rlpr7V9gw5A7epAKELMNgdM88d9rA/R+ArDoo7jd8
         VjKtdyKu+TcARD5PDIVBPn10GGihdwTs9qLbC47a9A9TbHLSJmhuvTibVDPXdtFsHtSs
         C7lX/Xv6SJTaLM19/kRdkp3c8cJNJrb+fK3Q32AoNo9YCD438YaDetTDpq/SGmOIgbUv
         c66q7tMnO02vbTInKc4o0vRrAxAvkBFNGbfv/6/V0AsS0ILgxHF3YlXw/BjcWOE5C6l1
         LZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5uDsHtEnAyV8LSXcbH33x3kolR6+Pd+L+XI2h0ZELA=;
        b=QX+q8xo/j4bTW84JPGT5If4MpFdpFpKgO597JsG13peTyGzf0qouMYZCJscSW0+A+H
         wwZuR4yhNbezwLkFH/3sPfL4wZarfMYXNl5SpXPZAfnMp/Ey+7IY0NWkQDVcV3iM0S7g
         cM/BGgikcK+EybciElfwdBtHldMidOdRMTmqTfmzlCaWdhBpg1R8Y8MYoHmkl2giplXX
         YwxNTT++iWkv/RHBLNnVSCIQCty2iIcCi85Bh/L6FIjWO0vbmWdV0POhThAsTTAnnB5Q
         nNnyzRJRbPgEMiC9VOAjQERS9Do3hsDRYr+fdxqx177I7pXgcOxt5t4CalYZQZ8+Ncla
         I/rw==
X-Gm-Message-State: APjAAAUkImpkbXQFQeDEbN1W2uh36Z6Y7jOYAuGHpI3mI6Inr/DHO650
        ac9LDcWcn70uhgemaqStOMQ=
X-Google-Smtp-Source: APXvYqy4Lzc9D8X48KWYpp9KjxD+6XJ9XparNQWCvrQusK/mtGINDs+3sU14TBkXf0GcODY1UnSfUQ==
X-Received: by 2002:a63:2042:: with SMTP id r2mr8220794pgm.32.1573172286899;
        Thu, 07 Nov 2019 16:18:06 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m68sm3688764pfb.122.2019.11.07.16.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:18:06 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 0/6] software node: add support for reference properties
Date:   Thu,  7 Nov 2019 16:17:57 -0800
Message-Id: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

These series implement "references" properties for software nodes as true
properties, instead of managing them completely separately.

The first 2 patches do away with separate handling of arrays vs
single-value properties, and treat everything as arrays (which really
matches how we handle OF or ACPI properties). Instead we recognize that
data, if it is small enough, may be embedded into property_entry
structure. As a side effect, properties can be converted from having their
data stored separately to embedding their data when they are being copied.

Patch #3 implements PROPERTY_ENTRY_REF() and friends; patch #4 converts
the user of references to the property syntax, and patch #5 removes the
remains of references as entities that are managed separately.

Patch #6 adds unit tests to verify that the handling of property
entries is correct.

Changed in v7:
- rebased onto next-20191107
- dropped already applied patches
- reworked patch that moved small properties inline on copying to
  avoid temporary allocation
- cleaned up logic for embedding vs storing values out-of-line
- fixed handling of embedded 2-element string array on x32

Changes in v6:
- rebased onto next-20191023
- fixed patch moving small properties inline
- fixed handling boolean properties after is_array -> is_inline
  conversion
- changed comments around is_inline "stored directly" vs embedded
  in one place (Andy)
- added unit tests for property entries based on KUnit framework
- added Any's reviewed-by/acked-by

Changes in v5:
- rebased onto next-20191011

Changes in v4:
- dealt with union aliasing concerns
- inline small properties on copy

Changes in v3:
- added various cleanups before implementing reference properties

Changes in v2:
- reworked code so that even single-entry reference properties are
  stored as arrays (i.e. the software_node_ref_args instances are
  not part of property_entry structure) to avoid size increase.
  From user's POV nothing is changed, one can still use PROPERTY_ENTRY_REF
  macro to define reference "inline".
- dropped unused DEV_PROP_MAX
- rebased on linux-next

Dmitry Torokhov (6):
  software node: rename is_array to is_inline
  software node: allow embedding of small arrays into property_entry
  software node: implement reference properties
  platform/x86: intel_cht_int33fe: use inline reference properties
  software node: remove separate handling of references
  software node: add basic tests for property entries

 drivers/base/swnode.c                         | 142 +++---
 drivers/base/test/Makefile                    |   2 +
 drivers/base/test/property-entry-test.c       | 472 ++++++++++++++++++
 .../platform/x86/intel_cht_int33fe_typec.c    |  81 +--
 include/linux/property.h                      |  84 ++--
 5 files changed, 640 insertions(+), 141 deletions(-)
 create mode 100644 drivers/base/test/property-entry-test.c

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

