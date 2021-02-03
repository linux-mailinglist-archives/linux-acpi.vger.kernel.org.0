Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3930E220
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 19:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBCSM4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 13:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhBCSMy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 13:12:54 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2DC06178C
        for <linux-acpi@vger.kernel.org>; Wed,  3 Feb 2021 10:12:11 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q9so144841ilo.1
        for <linux-acpi@vger.kernel.org>; Wed, 03 Feb 2021 10:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SB8riJOjuzgjOw1Wsc94yZlZbRu0f544yG+Du9Zqdfg=;
        b=GqNljR3NKsjx1aOKKKpu7DPYAayE0yJ1cSIeVoqtDg/UDvcqLkBOFJN8mTXuu8AlnW
         2/qg3wBHa6u37PqvAHoL/TEHy1UG6FAH/6PalY0HU1l079BwcJ9zMWmrZkugS+4apyhL
         MeaUsA/GGDyF1u4u0949ghfqeRJPJK9inRKG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SB8riJOjuzgjOw1Wsc94yZlZbRu0f544yG+Du9Zqdfg=;
        b=QvnpYRpvju+Xm6zZFD4QKiqaw3FPu0PJee3vojYmuyVDbw2yVqPmPtgwaMin9Quml9
         mPiIAGEMCQzHnu4sBkha33p+dsygQsF2d/BOPiUgQKaueZ8EZEzq6yQq+EI13i5mFWur
         C8wXQ0gVI4LexbdkL4Q+JWsWbP/i0v2lyt3HWjnw+ycy59o4hvZJOvbGLt//F5CIMYi6
         VjwImYBSzM9qf1WfQN/EKEW0hXh5kJQc30k7Erb+qWDmYuJiuWZeZZkI5Yxm/pcyWTdZ
         E3iotOcIqjANv3J5aZ5TILDyqRhV8sGdspqE0jkgtKOUwEAgNhjXKu+Lqo55BH7AICe/
         Stgw==
X-Gm-Message-State: AOAM531znoeo6r2M9HFiQHOjsaqQe6TYmiLAvbmwh5n/R7khJ1qx5n1T
        mNJLfmklJoeJRAr+O96VbEDJHw==
X-Google-Smtp-Source: ABdhPJz2RPi0I2OuoWXqMNIMCO4ew11k/K1o0MoxUBjXKxBLRiPZWJwL//3sB8cqqu6t1+eIdcNEkg==
X-Received: by 2002:a92:2e05:: with SMTP id v5mr3876876ile.241.1612375930585;
        Wed, 03 Feb 2021 10:12:10 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h21sm399684iob.30.2021.02.03.10.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 10:12:09 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, peterz@infradead.org,
        keescook@chromium.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 0/7] Introduce Sequence Number Ops 
Date:   Wed,  3 Feb 2021 11:11:56 -0700
Message-Id: <cover.1612314468.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters.

There are a number of atomic_t usages in the kernel where atomic_t api
is used for counting sequence numbers and other statistical counters.
Several of these usages, convert atomic_read() and atomic_inc_return()
return values to unsigned. Introducing sequence number ops supports
these use-cases with a standard core-api.

Sequence Number ops provide interfaces to initialize, increment and get
the sequence number. These ops also check for overflow and log message to
indicate when overflow occurs. This check is intended to help catch cases
where overflow could lead to problems.

Since v2:
- Uses atomic_inc_return() for incrementing the sequence number.
- No longer uses atomic_read()

Shuah Khan (7):
  seqnum_ops: Introduce Sequence Number Ops
  selftests: lib:test_seqnum_ops: add new test for seqnum_ops
  drivers/acpi: convert seqno to use seqnum_ops
  drivers/acpi/apei: convert seqno to seqnum_ops
  drivers/staging/rtl8723bs: convert event_seq to use seqnum_ops
  drivers/staging/rtl8188eu: convert event_seq to use seqnum_ops
  kobject: convert uevent_seqnum to seqnum_ops

 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/seqnum_ops.rst         |  62 ++++++++
 MAINTAINERS                                   |   8 ++
 drivers/acpi/acpi_extlog.c                    |   8 +-
 drivers/acpi/apei/ghes.c                      |   8 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  23 ++-
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |   3 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |   3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  33 +++--
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |   3 +-
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |   3 +-
 include/linux/kobject.h                       |   3 +-
 include/linux/seqnum_ops.h                    | 131 +++++++++++++++++
 kernel/ksysfs.c                               |   3 +-
 lib/Kconfig                                   |   9 ++
 lib/Makefile                                  |   1 +
 lib/kobject_uevent.c                          |   9 +-
 lib/test_seqnum_ops.c                         | 133 ++++++++++++++++++
 tools/testing/selftests/lib/Makefile          |   1 +
 tools/testing/selftests/lib/config            |   1 +
 .../testing/selftests/lib/test_seqnum_ops.sh  |  10 ++
 21 files changed, 423 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/core-api/seqnum_ops.rst
 create mode 100644 include/linux/seqnum_ops.h
 create mode 100644 lib/test_seqnum_ops.c
 create mode 100755 tools/testing/selftests/lib/test_seqnum_ops.sh

-- 
2.27.0

