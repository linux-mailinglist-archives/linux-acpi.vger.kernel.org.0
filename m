Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC85D1C0B83
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 03:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgEABNH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Apr 2020 21:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABNG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Apr 2020 21:13:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733B3C035494
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2020 18:13:06 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e26so1454380otr.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2020 18:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1EppxRrve6S2zF12WqlNXwmHbnuWXeqHARTl/wNCU8Y=;
        b=WRHpBU/GNAKk880b5Z9J11XG5nQ0/TVxmXxt7OIfaHJXeGXe4J4fzDHckGhVLnMECm
         FQqKBrGPxkybli2JAm1hUdlLaSgmM7/dPD24i6rccs/YvPX0LHYPGKoLcSEW7VXzQ6Wu
         weyL1QrNF7v872ohncqX3BOein7Ps5ugjyRUxM43CCX4+8kVPxPOwlX67vV+TtDQ0TJ/
         8paYOJl+Wvk74/SAtK+4oND4YGf31TQFZ7tnDDNcwedPVfSjbhV4ZBzwUhDZ1Fd3vYlV
         TFxE8LdIG1g46Wr4wydz8692dfrzrFuGGokD/gyDJBDazdCQxovchgJD1BGO1AedHLAQ
         lAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1EppxRrve6S2zF12WqlNXwmHbnuWXeqHARTl/wNCU8Y=;
        b=KZelhDtReruJ7kPWazh0gmACie15JzT9qRnrfnjlPOihtmCIIvljATYNPc40YIjZze
         B1YRNZh75KLIbDJpcggzVnrUHYPotePfVP2BFY8WJaFz+tReHFa6VsqECPfU+NzOpvU/
         NvGrVzIcUTBrDqK9ni7tmpXJ/ZOwf9TZsGbNrpHOUKwLgFFYwC1SwUxupHgE6pbPM/kY
         RhZOF3N5u9DCUKGbglOcD+pSpUWTUkb852cOPZQQSZ1OgschohlvEB05Xi4ibkjW068O
         KQzsay5yOcoSiXTu6VFobTKxt6cndrnScJ3U8Au2/djKUDNcSBXdS4X2wHMDIqvYcRlF
         C2sA==
X-Gm-Message-State: AGi0PuYFw+ssDLtghkS46pI/2FCU1RqRqd0qif9h33R8aueg8ZXv2BNy
        CK4MI0ZTGV2VE+F9A+lleZpkmUSVW8zIVLgVkfY=
X-Google-Smtp-Source: APiQypIBVcDEeQcb4QCv4O+rguy8PO+DQD41c/vIfdqwizoZsHJpx008cxIJIlXNt7luagas5BQCJ91QQ5U2mcsnnMk=
X-Received: by 2002:a05:6830:4d6:: with SMTP id s22mr1706873otd.129.1588295585794;
 Thu, 30 Apr 2020 18:13:05 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date:   Fri, 1 May 2020 09:12:55 +0800
Message-ID: <CANTwqXATxhOVXC0OLcSMLeuhKLPM6+Mjas4tpQarLRRD5+aWJQ@mail.gmail.com>
Subject: =?UTF-8?Q?drivers=2Facpi=2Fsysfs=2Ec=EF=BC=9Aa_kobject_memleak_in_acpi=5Fsys?=
        =?UTF-8?Q?fs=5Fadd=5Fhotplug=5Fprofile=3F?=
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,
I notice that most of the usage of kobject_init_and_add in drivers are
wrong, and now some drivers code has maken it right
please see commit dfb5394f804e (https://lkml.org/lkml/2020/4/11/282)
function acpi_sysfs_add_hotplug_profile() in drivers/acpi/sysfs.c may
have the similar issue and leak kobject.
if kobject_init_and_add() failed, the hotplug->kobj may already
increased it's refcnt and allocated memory to store it's name,
so a kobject_put is need before return.
void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
   const char *name)
{
int error;

if (!hotplug_kobj)
goto err_out;

error = kobject_init_and_add(&hotplug->kobj,
&acpi_hotplug_profile_ktype, hotplug_kobj, "%s", name);
if (error)
goto err_out;

kobject_uevent(&hotplug->kobj, KOBJ_ADD);
return;

 err_out:
pr_err(PREFIX "Unable to add hotplug profile '%s'\n", name);
}


Best regards,
Lin Yi
