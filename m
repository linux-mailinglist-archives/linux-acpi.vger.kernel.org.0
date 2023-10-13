Return-Path: <linux-acpi+bounces-629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0031E7C8B8D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 18:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4AF280D48
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FC821A0B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208311CBC
	for <linux-acpi@vger.kernel.org>; Fri, 13 Oct 2023 15:39:43 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0582DD9;
	Fri, 13 Oct 2023 08:39:41 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57de3096e25so371375eaf.1;
        Fri, 13 Oct 2023 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211580; x=1697816380;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syMSn9bUGI1mYgk9z5rjv/7N6cpGdLeuuA9bThnQHjE=;
        b=fHq2b+XJ5tKAlPiS9J/Xcq1sgOxH8i2OZWyxtv2RQyT257OBIwqprv3dzfP3IjX5yE
         jT7J0PJ+oE2AF5rWqOBcXG2jv/YgQDYpzyTLqfrtuYLhMmwLKztZRqgYBkCCyr9VZBGC
         RPUd25haEEc2rnRFSoW62HVyc9BuFD8NkRz6T3bUIxKrcCYSqwHu94P76PRdf0NyASQa
         trMiYylaod0rZknQcd4dwyKAx2X3u4MO8PhSEAF1Q9k6iKfGJorFZTETPLxFhVaYBSr/
         Ku7QNQfjBgv4+RzzlvYmI7cLsEVZNaxW1tqiyIejQM2Avdj4Cwd0ZMQvdBVyzMFR1eU/
         oXLw==
X-Gm-Message-State: AOJu0Yz/lcBopY+RaA2ZOu34PKj7ZNF3+G9e8pXU7T5c8OLbcyU8Sxlb
	EL67Q6PIqXUMQ1P74F6mA+SybDAOzA0ymY1m2cg=
X-Google-Smtp-Source: AGHT+IFKVQwLA+paHmJiyVg59OuJh00iVZg+9+X6ncKE6igTumBnt45lx63TZvGa0b73Zv1ta0ASGVjm61l6Y/Y3xwE=
X-Received: by 2002:a4a:decf:0:b0:581:5990:dbb8 with SMTP id
 w15-20020a4adecf000000b005815990dbb8mr8396496oou.0.1697211580281; Fri, 13 Oct
 2023 08:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Oct 2023 17:39:29 +0200
Message-ID: <CAJZ5v0gcP2o_mDOyWP_C3u+6nHqT8gXFhUxGHSC7OgywBXsNMQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.6-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.6-rc6

with top-most commit 9bc2fb9a7e41542a193658deff3df572fa24cb68

 Merge branches 'acpi-ec' and 'acpi-resource'

on top of commit 94f6f0550c625fab1f373bb86a6669b45e9748b3

 Linux 6.6-rc5

to receive ACPI fixes for 6.6-rc6.

These add an ACPI EC GPE detection quirk for HP Pavilion Gaming
15-dk1xxx and ACPI IRQ override quirks for TongFang GM6BGEQ, GM6BG5Q
and GM6BG0Q, and for ASUS ExpertBook B1402CBA (Hans de Goede).

Thanks!


---------------

Hans de Goede (3):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
      ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
      ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q to
irq1_edge_low_force_override[]

---------------

 drivers/acpi/ec.c       | 11 +++++++++++
 drivers/acpi/resource.c | 26 ++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

