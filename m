Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5464B3D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfGJRJ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 13:09:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfGJRJ6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jul 2019 13:09:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so3303408wrm.1;
        Wed, 10 Jul 2019 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FUMYTPUmcDHl7LRaEDJawKk0dtQ5ypvTZlH1dSLqDtQ=;
        b=MhLBJ0dybN/7TXyREFpNRVytGTmtXBCS6unAitKLyB4BCdEth+9B02jjQJ3C7b6bHl
         d5qABPzAIa0sbAdqZ3TPnZMub8FsMd6n8wMIspGigeoy4gF0t7xHx94mUpwZZ/tH5Z1n
         k6MoHhOz0FRwZ01zn8M6R3JJaw5A5BEpAxssKA0M7CQ+WtdVU6q72BwvTflbNxJzfRFF
         0J2nyWU3qoxm6FxjoT6dVT7coJQIC+mAuXwV0c7W9cWmbdowOZjCxnwiKJTWzXeBMqAw
         MCjOx4QRt+7VZhMOCfRgQU6MOR1lQS/xRy6ePBRdwaHbn9FPOzNDxJ60YQLu0X/2yL4G
         ShKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUMYTPUmcDHl7LRaEDJawKk0dtQ5ypvTZlH1dSLqDtQ=;
        b=E0yltlKQWfD+y+My+zZOO6G442TPCvj0sJmwtZMq3Gvbh6tYLjwwhLzoMyjDgYn4wi
         oMqUl8r9bYYz375KpLtnFEcQ/NC3FTy2lxBzbxjmTf4scJqU2Cs+mhchGiKAkucWxv5U
         AuiCoXo2WVKQv1pil+4J95uA/K9lxAyqUHzX6ByFtgmH7X5ipRIPqa7fVPd4SpSU+CEG
         gdyxhIv2ULekN7mUhGOiqPbtDYAVTtxTnuUao1GjbTeQ3eHa3eUHxm/1xSuGduu/FcmQ
         vLXMvTKG7fGtZZ0HokHRxtCieQTBVHwiC9fjJI6dHNCvv6infxYfMz6d26G1pC0nmskX
         aumw==
X-Gm-Message-State: APjAAAWEM7SJg3l6nK5Zu2JfxO5Ez6D91sKV5sJhPzL5wpa6a1qQAO44
        uZXG2N9KPIVLJDNZxOZHvVU=
X-Google-Smtp-Source: APXvYqx1b/Ila5J0gONdnVlH02E+WdlIukUb1Jpr5YUdksSK0UAD3hson9uJD8Xdki+bEd673dGBiA==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr34192333wrv.346.1562778596001;
        Wed, 10 Jul 2019 10:09:56 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id w14sm2739270wrk.44.2019.07.10.10.09.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:09:55 -0700 (PDT)
Date:   Wed, 10 Jul 2019 10:09:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] acpi: blacklist: fix clang warning for unused dmi table
Message-ID: <20190710170953.GA80585@archlinux-threadripper>
References: <20190710130555.1829974-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710130555.1829974-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 10, 2019 at 03:05:43PM +0200, Arnd Bergmann wrote:
> When CONFIG_DMI is disabled, we only have a tentative declaration,
> which causes a warning from clang:
> 
> drivers/acpi/blacklist.c:20:35: error: tentative array definition assumed to have one element [-Werror]
> static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;
> 
> As the variable is not actually used here, hide it entirely
> in an #ifdef to shut up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
