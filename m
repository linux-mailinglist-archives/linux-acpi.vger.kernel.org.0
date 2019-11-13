Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C862CFA687
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 03:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKMCgL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Nov 2019 21:36:11 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34631 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfKMCgJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Nov 2019 21:36:09 -0500
Received: by mail-pf1-f201.google.com with SMTP id a1so450586pfn.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2019 18:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j/m5gKoO0jXE5BYiRELmqLQO+KOEzq6qVcGYQdzOaSA=;
        b=XgT9OOUk3Yzbi5DcZ2hay2pQFUGc1C8JY/5SA0LlfseAK+RhPY+71H6xpSldWlhSUe
         R9GgGqV4at+vdSBUE8daDaNeFdK+nLrVVaDX/LAkaLhuF3uf6imXA+7dLiENKvXLfaWp
         iLdt55FdJCRJZ1R1A5pWhqZj+jjlwzp4usrjP2FUtoZyo114DxMiDZ5jfZHluHJgnbBA
         8QRRFNIdOTHX9gS5bdLMBT6zr1BxIyqjIk4upS3q+n7pWPeFmF5OfwpZbWYU8drHzMhO
         jjpTtkobVVPWzyCvqti8iv4ADbXMyvD0D0UsAez45khHi5TiY/0D42l5dprS4XOUaWpD
         vb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j/m5gKoO0jXE5BYiRELmqLQO+KOEzq6qVcGYQdzOaSA=;
        b=TRbOviM3B7xUykTCOY6c1c0hiEnQbY5q1FVi0TGcI1oTF2PgE3pLNJET42/JpMlXQP
         Sm2yTnj6rvkMyflRWGee/Qsjq3+cOnon+aycluSai6Egd6dVqPLOKUMuC3wNQIxbEqzc
         PUeMC4f6KKW4DEl7QBT8wmu/qqiW/FZa0fVsODLBInTiByUL6bEhghxg7uFRjAA80DXj
         PNhFdmGyi4C6/oCR10G9BQi8Jx993g0lZhtM+1qhrCuf01TrD/Nzr5HQ+693NjdqROof
         dd088Dab0RVufyU/1bWGll7dcGh4W5A7hDnPKhyoXKZDG3EZtYLiNsqUiZ3LMPpltI98
         leMA==
X-Gm-Message-State: APjAAAWgQLj/ayV0tMDh+z3zPDwECLtwRy/jo3UR8yQEuFnOGW3809Hd
        DyY/sHOz4xu9not/XpKvRyyYJKRZzBsqvNU=
X-Google-Smtp-Source: APXvYqy/iTcBCYhhvymxkn9JScQwGqIbVYAjgoqO+QvFZA1fjoiQ8ng2UZoFhvy3CTVKg4ofr5GXs6lQhmmutcw=
X-Received: by 2002:a63:8f5e:: with SMTP id r30mr933408pgn.146.1573612568112;
 Tue, 12 Nov 2019 18:36:08 -0800 (PST)
Date:   Tue, 12 Nov 2019 18:35:59 -0800
In-Reply-To: <20191113023559.62295-1-saravanak@google.com>
Message-Id: <20191113023559.62295-2-saravanak@google.com>
Mime-Version: 1.0
References: <20191113023559.62295-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v1] driver core: Clarify documentation for fwnode_operations.add_links()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The wording was a bit ambiguous. So update it to make it clear.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 include/linux/fwnode.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 766ff9bb5876..23df37f85398 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -94,15 +94,16 @@ struct fwnode_reference_args {
  *		available suppliers.
  *
  *		Return 0 if device links have been successfully created to all
- *		the suppliers this device needs to create device links to or if
- *		the supplier information is not known.
+ *		the known suppliers of this device or if the supplier
+ *		information is not known.
  *
- *		Return -ENODEV if and only if the suppliers needed for probing
- *		the device are not yet available to create device links to.
+ *		Return -ENODEV if the suppliers needed for probing this device
+ *		have not been registered yet (because device links can only be
+ *		created to devices registered with the driver core).
  *
- *		Return -EAGAIN if there are suppliers that need to be linked to
- *		that are not yet available but none of those suppliers are
- *		necessary for probing this device.
+ *		Return -EAGAIN if some of the suppliers of this device have not
+ *		been registered yet, but none of those suppliers are necessary
+ *		for probing the device.
  */
 struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

