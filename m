Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948BA3FBCA3
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Aug 2021 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhH3Sqn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Aug 2021 14:46:43 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38578 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhH3Sqn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Aug 2021 14:46:43 -0400
Received: by mail-oi1-f175.google.com with SMTP id u25so15228209oiv.5;
        Mon, 30 Aug 2021 11:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vl+usJ71P4/PlgtLXP3kg6YBOTCmsK6JnvVn3SrPT94=;
        b=ZgTBNarBpqmU+OcBSkeG81ysZ5lEMB7bUBI/j2KLXwpmwgL0px7DxMVGDuMiTOuvNw
         J1z4jxQ6VMQjn837U5NSKmNFvqZvYvJvEGRHk+5nej5vx/W4dbjZldy8OTaDbh596P1D
         oxTw4Yd+P75qdzuUSC7zPLZqGN1WpP33nRO6Dyr3Wqf5P6ds0/h+e9lLvVpNtYjkpwdy
         WTksc0jK+WIwlpbq6rYoSjEC4Hjct1gtDFw3koktPk8uxYYbd/7nBbJje0G4g4c3F/X9
         4L3Q4Rb4n/rChOHe8UclV/N4GJAVO8Z8c1LnSi/tINNSOZUs8HyoVfzY1eWNqgtg+pLD
         Noig==
X-Gm-Message-State: AOAM530ZUJ6G4hyBb8F9n1lXsywnwjsdr3W5HBG/iu5lZNBYJo7PfhGR
        lvfUTbr5mgaxvG6KGV3MaH7K1JgPlm6fGThZI/o=
X-Google-Smtp-Source: ABdhPJwTde7kQwugeIZDo6BP76iUdCtUx1SWczsiZTTYIeH1Yi0oQqllH33J7AbdoimyaWkgKLR7/H440CvxDuQ+WRQ=
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr397528ois.157.1630349149186;
 Mon, 30 Aug 2021 11:45:49 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Aug 2021 20:45:38 +0200
Message-ID: <CAJZ5v0icj4uaJ7NuH+V-JQ_5h238juqPsx173Xcs2dMaRK9nvA@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.15-rc1

with top-most commit a90887705668fc5587bf5092c38f353ad36c69fd

 Revert "media: device property: Call
fwnode_graph_get_endpoint_by_id() for fwnode->secondary"

on top of commit 7c60610d476766e128cc4284bb6349732cbd6606

 Linux 5.14-rc6

to receive device properties framework changes for 5.15-rc1.

These improve the handling of secondary firmware nodes in
fwnode_graph_get_next_endpoint() (Daniel Scally).

Thanks!


---------------

Daniel Scally (2):
      device property: Check fwnode->secondary in
fwnode_graph_get_next_endpoint()
      Revert "media: device property: Call
fwnode_graph_get_endpoint_by_id() for fwnode->secondary"

---------------

 drivers/base/property.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)
