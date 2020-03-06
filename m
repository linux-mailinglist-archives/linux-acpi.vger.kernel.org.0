Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70B17BA0E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 11:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgCFKUN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Mar 2020 05:20:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39230 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFKUN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2020 05:20:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id x97so1902623ota.6;
        Fri, 06 Mar 2020 02:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Mal+x1JmrCy7zwZs9KPsswluRim3HphUgYrnlEClDdE=;
        b=Xniqih+iqcsNXEOWFzWhQgDXhAB+8nt1LEZoOmZVXTj6rkETDZvoHdManIGcRf0Uob
         07awvZZxfRb1pElGsvNXVx+v6mJSlcxfZB2Y6ayWhj93wY3pOD+EeG8UuUQqU/Tv/vqe
         GZpT1kGJM8pn7LSffE5ZSdNqkFzSHYVIxkZ4+wkxBJ2RZ5+eJNG6unuRjWy75Sx4stAW
         A1uXenMNTTUyFr1XuzyUdonAkXeR1opquf9MSCL5AZuer361WxO6AKN57ho3FGYidG0z
         zBP2gdAlrX3Bgul7u2VyYwokDZeNvE+7JMmPq0JyQZ0+7ExsPREQIM6oU+hI7iH9KB+J
         VVaA==
X-Gm-Message-State: ANhLgQ0q5rVcKKCe7Hgo1gK205hvel0GQWHPEi2iDOrE1LIeSZH0jLdK
        4yfZ7gQt6OA2ANB0U+kXc5gmOwKX4Mg0zkXtZYp5jLwq
X-Google-Smtp-Source: ADFU+vvZYSEfh9IaW1N2dhdzBJK6wf6jhcKcDKKi5QFrmON0XXLEtAiopT6g4y/kfHa+ooMThsR9xoi/7dA9ZmUEYNI=
X-Received: by 2002:a9d:6b04:: with SMTP id g4mr1765710otp.167.1583490012633;
 Fri, 06 Mar 2020 02:20:12 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Mar 2020 11:20:01 +0100
Message-ID: <CAJZ5v0j8jvHpHW+BBALg9L8=hq8PjyVyMQHfUCmusMeTLDifVg@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fix for v5.6-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.6-rc5

with top-most commit 7589238a8cf37331607c3222a64ac3140b29532d

 Revert "software node: Simplify software_node_release() function"

on top of commit 98d54f81e36ba3bf92172791eba5ca5bd813989b

 Linux 5.6-rc4

to receive a device properties framework fix for 5.6-rc5.

This reverts a problematic commit from the 5.3 development
cycle (Brendan Higgins).

Thanks!


---------------

Brendan Higgins (1):
      Revert "software node: Simplify software_node_release() function"

---------------

 drivers/base/swnode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
