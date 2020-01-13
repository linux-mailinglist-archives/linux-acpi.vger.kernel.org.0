Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D93138FAC
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2020 11:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgAMK4u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jan 2020 05:56:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34098 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMK4u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jan 2020 05:56:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so7841582oig.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2020 02:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jvj9lTVrKQ9U2LozCH+5mW1LeDHFUOyrgU4z4is2HCY=;
        b=h7GUWNw4vIf5syE3E74ZV3vObR0Q9fXwTYCWyHzNmcq6YM59+ISBIgoXbvMv+SGbVJ
         yoXS0zb7AkYk7Cy/S32h1OCaTjlhx4eHoiDu1qR6IESkljWb6fvHiIniV0i5tfK2H+5A
         ipzUJUUVTJd6kWAxKJjpMj/FDU36atvB/VcnJqP0nXoNgfxE0Cy5DI384z5YHeJYVU6+
         cEKAWmtP7KCAzm5T2qfHPhQr9gtvqyKiJgmqcIp5M81oAi/UmkUjycUFXmNSxZoBOa2J
         b7jazAJ1Xjsho+UWaIfhy9ixT5UUipWCOH9AqPj9BuCLOEAr1RSa+8slOrkg8b+8vOmk
         rzlw==
X-Gm-Message-State: APjAAAWDm5Z+HpDZSB32TqtTN5ugCmn+muOj85l4L5jAJtYCpjLN8+aY
        lJ+fb0RFELNkXZ97tSrV8VE/vRasgoLE5/H/2qXK2w==
X-Google-Smtp-Source: APXvYqyBm1kIqgCkJVhNcvCBtjVthSYUDD13DSO/xlkfgJOjOR9XfrXkBPEq0j0Mvx3h/5w2myvCYIDdjZuKodOSeJg=
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr12683081oic.57.1578913009112;
 Mon, 13 Jan 2020 02:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20200110193150.4196-1-erik.kaneda@intel.com>
In-Reply-To: <20200110193150.4196-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jan 2020 11:56:38 +0100
Message-ID: <CAJZ5v0gDsi9-4r8Pns=XJijFdtKTLZuwDyNBApXYwAwZKoNAFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPICA version 20200110
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 10, 2020 at 8:52 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This is the Linux-ized 20200110 release of ACPICA. This updates the
> copyright year in all ACPICA files. This patch is rather large and may
> be rejected by the Linux ACPI mailing list. If this is the case, the
> patch set is available at the following link:
>
> https://github.com/SchmErik/linux/tree/20200110
>
>
> Bob Moore (2):
>   ACPICA: All acpica: Update copyrights to 2020 Including tool signons.
>   ACPICA: Update version to 20200110
>
>  drivers/acpi/acpica/acapps.h                             | 4 ++--
>  drivers/acpi/acpica/accommon.h                           | 2 +-
>  drivers/acpi/acpica/acconvert.h                          | 2 +-
>  drivers/acpi/acpica/acdebug.h                            | 2 +-
>  drivers/acpi/acpica/acdispat.h                           | 2 +-
>  drivers/acpi/acpica/acevents.h                           | 2 +-
>  drivers/acpi/acpica/acglobal.h                           | 2 +-
>  drivers/acpi/acpica/achware.h                            | 2 +-
>  drivers/acpi/acpica/acinterp.h                           | 2 +-
>  drivers/acpi/acpica/aclocal.h                            | 2 +-
>  drivers/acpi/acpica/acmacros.h                           | 2 +-
>  drivers/acpi/acpica/acnamesp.h                           | 2 +-
>  drivers/acpi/acpica/acobject.h                           | 2 +-
>  drivers/acpi/acpica/acopcode.h                           | 2 +-
>  drivers/acpi/acpica/acparser.h                           | 2 +-
>  drivers/acpi/acpica/acpredef.h                           | 2 +-
>  drivers/acpi/acpica/acresrc.h                            | 2 +-
>  drivers/acpi/acpica/acstruct.h                           | 2 +-
>  drivers/acpi/acpica/actables.h                           | 2 +-
>  drivers/acpi/acpica/acutils.h                            | 2 +-
>  drivers/acpi/acpica/amlcode.h                            | 2 +-
>  drivers/acpi/acpica/amlresrc.h                           | 2 +-
>  drivers/acpi/acpica/dbhistry.c                           | 2 +-
>  drivers/acpi/acpica/dsargs.c                             | 2 +-
>  drivers/acpi/acpica/dscontrol.c                          | 2 +-
>  drivers/acpi/acpica/dsdebug.c                            | 2 +-
>  drivers/acpi/acpica/dsfield.c                            | 2 +-
>  drivers/acpi/acpica/dsinit.c                             | 2 +-
>  drivers/acpi/acpica/dsmethod.c                           | 2 +-
>  drivers/acpi/acpica/dsobject.c                           | 2 +-
>  drivers/acpi/acpica/dsopcode.c                           | 2 +-
>  drivers/acpi/acpica/dspkginit.c                          | 2 +-
>  drivers/acpi/acpica/dswexec.c                            | 2 +-
>  drivers/acpi/acpica/dswload.c                            | 2 +-
>  drivers/acpi/acpica/dswload2.c                           | 2 +-
>  drivers/acpi/acpica/dswscope.c                           | 2 +-
>  drivers/acpi/acpica/dswstate.c                           | 2 +-
>  drivers/acpi/acpica/evevent.c                            | 2 +-
>  drivers/acpi/acpica/evglock.c                            | 2 +-
>  drivers/acpi/acpica/evgpe.c                              | 2 +-
>  drivers/acpi/acpica/evgpeblk.c                           | 2 +-
>  drivers/acpi/acpica/evgpeinit.c                          | 2 +-
>  drivers/acpi/acpica/evgpeutil.c                          | 2 +-
>  drivers/acpi/acpica/evhandler.c                          | 2 +-
>  drivers/acpi/acpica/evmisc.c                             | 2 +-
>  drivers/acpi/acpica/evregion.c                           | 2 +-
>  drivers/acpi/acpica/evrgnini.c                           | 2 +-
>  drivers/acpi/acpica/evxface.c                            | 2 +-
>  drivers/acpi/acpica/evxfevnt.c                           | 2 +-
>  drivers/acpi/acpica/evxfgpe.c                            | 2 +-
>  drivers/acpi/acpica/evxfregn.c                           | 2 +-
>  drivers/acpi/acpica/exconcat.c                           | 2 +-
>  drivers/acpi/acpica/exconfig.c                           | 2 +-
>  drivers/acpi/acpica/exconvrt.c                           | 2 +-
>  drivers/acpi/acpica/excreate.c                           | 2 +-
>  drivers/acpi/acpica/exdebug.c                            | 2 +-
>  drivers/acpi/acpica/exdump.c                             | 2 +-
>  drivers/acpi/acpica/exfield.c                            | 2 +-
>  drivers/acpi/acpica/exfldio.c                            | 2 +-
>  drivers/acpi/acpica/exmisc.c                             | 2 +-
>  drivers/acpi/acpica/exmutex.c                            | 2 +-
>  drivers/acpi/acpica/exnames.c                            | 2 +-
>  drivers/acpi/acpica/exoparg1.c                           | 2 +-
>  drivers/acpi/acpica/exoparg2.c                           | 2 +-
>  drivers/acpi/acpica/exoparg3.c                           | 2 +-
>  drivers/acpi/acpica/exoparg6.c                           | 2 +-
>  drivers/acpi/acpica/exprep.c                             | 2 +-
>  drivers/acpi/acpica/exregion.c                           | 2 +-
>  drivers/acpi/acpica/exresnte.c                           | 2 +-
>  drivers/acpi/acpica/exresolv.c                           | 2 +-
>  drivers/acpi/acpica/exresop.c                            | 2 +-
>  drivers/acpi/acpica/exserial.c                           | 2 +-
>  drivers/acpi/acpica/exstore.c                            | 2 +-
>  drivers/acpi/acpica/exstoren.c                           | 2 +-
>  drivers/acpi/acpica/exstorob.c                           | 2 +-
>  drivers/acpi/acpica/exsystem.c                           | 2 +-
>  drivers/acpi/acpica/extrace.c                            | 2 +-
>  drivers/acpi/acpica/exutils.c                            | 2 +-
>  drivers/acpi/acpica/hwacpi.c                             | 2 +-
>  drivers/acpi/acpica/hwesleep.c                           | 2 +-
>  drivers/acpi/acpica/hwgpe.c                              | 2 +-
>  drivers/acpi/acpica/hwsleep.c                            | 2 +-
>  drivers/acpi/acpica/hwtimer.c                            | 2 +-
>  drivers/acpi/acpica/hwvalid.c                            | 2 +-
>  drivers/acpi/acpica/hwxface.c                            | 2 +-
>  drivers/acpi/acpica/hwxfsleep.c                          | 2 +-
>  drivers/acpi/acpica/nsarguments.c                        | 2 +-
>  drivers/acpi/acpica/nsconvert.c                          | 2 +-
>  drivers/acpi/acpica/nsdump.c                             | 2 +-
>  drivers/acpi/acpica/nsdumpdv.c                           | 2 +-
>  drivers/acpi/acpica/nsinit.c                             | 2 +-
>  drivers/acpi/acpica/nsload.c                             | 2 +-
>  drivers/acpi/acpica/nsparse.c                            | 2 +-
>  drivers/acpi/acpica/nspredef.c                           | 2 +-
>  drivers/acpi/acpica/nsprepkg.c                           | 2 +-
>  drivers/acpi/acpica/nsrepair.c                           | 2 +-
>  drivers/acpi/acpica/nsrepair2.c                          | 2 +-
>  drivers/acpi/acpica/nsutils.c                            | 2 +-
>  drivers/acpi/acpica/nswalk.c                             | 2 +-
>  drivers/acpi/acpica/nsxfname.c                           | 2 +-
>  drivers/acpi/acpica/psargs.c                             | 2 +-
>  drivers/acpi/acpica/psloop.c                             | 2 +-
>  drivers/acpi/acpica/psobject.c                           | 2 +-
>  drivers/acpi/acpica/psopcode.c                           | 2 +-
>  drivers/acpi/acpica/psopinfo.c                           | 2 +-
>  drivers/acpi/acpica/psparse.c                            | 2 +-
>  drivers/acpi/acpica/psscope.c                            | 2 +-
>  drivers/acpi/acpica/pstree.c                             | 2 +-
>  drivers/acpi/acpica/psutils.c                            | 2 +-
>  drivers/acpi/acpica/pswalk.c                             | 2 +-
>  drivers/acpi/acpica/psxface.c                            | 2 +-
>  drivers/acpi/acpica/tbdata.c                             | 2 +-
>  drivers/acpi/acpica/tbfadt.c                             | 2 +-
>  drivers/acpi/acpica/tbfind.c                             | 2 +-
>  drivers/acpi/acpica/tbinstal.c                           | 2 +-
>  drivers/acpi/acpica/tbprint.c                            | 2 +-
>  drivers/acpi/acpica/tbutils.c                            | 2 +-
>  drivers/acpi/acpica/tbxface.c                            | 2 +-
>  drivers/acpi/acpica/tbxfload.c                           | 2 +-
>  drivers/acpi/acpica/tbxfroot.c                           | 2 +-
>  drivers/acpi/acpica/utaddress.c                          | 2 +-
>  drivers/acpi/acpica/utalloc.c                            | 2 +-
>  drivers/acpi/acpica/utascii.c                            | 2 +-
>  drivers/acpi/acpica/utbuffer.c                           | 2 +-
>  drivers/acpi/acpica/utcache.c                            | 2 +-
>  drivers/acpi/acpica/utcopy.c                             | 2 +-
>  drivers/acpi/acpica/utdebug.c                            | 2 +-
>  drivers/acpi/acpica/utdecode.c                           | 2 +-
>  drivers/acpi/acpica/uteval.c                             | 2 +-
>  drivers/acpi/acpica/utglobal.c                           | 2 +-
>  drivers/acpi/acpica/uthex.c                              | 2 +-
>  drivers/acpi/acpica/utids.c                              | 2 +-
>  drivers/acpi/acpica/utinit.c                             | 2 +-
>  drivers/acpi/acpica/utlock.c                             | 2 +-
>  drivers/acpi/acpica/utobject.c                           | 2 +-
>  drivers/acpi/acpica/utosi.c                              | 2 +-
>  drivers/acpi/acpica/utpredef.c                           | 2 +-
>  drivers/acpi/acpica/utprint.c                            | 2 +-
>  drivers/acpi/acpica/uttrack.c                            | 2 +-
>  drivers/acpi/acpica/utuuid.c                             | 2 +-
>  drivers/acpi/acpica/utxface.c                            | 2 +-
>  drivers/acpi/acpica/utxfinit.c                           | 2 +-
>  include/acpi/acbuffer.h                                  | 2 +-
>  include/acpi/acconfig.h                                  | 2 +-
>  include/acpi/acexcep.h                                   | 2 +-
>  include/acpi/acnames.h                                   | 2 +-
>  include/acpi/acoutput.h                                  | 2 +-
>  include/acpi/acpi.h                                      | 2 +-
>  include/acpi/acpiosxf.h                                  | 2 +-
>  include/acpi/acpixf.h                                    | 4 ++--
>  include/acpi/acrestyp.h                                  | 2 +-
>  include/acpi/actbl.h                                     | 2 +-
>  include/acpi/actbl1.h                                    | 2 +-
>  include/acpi/actbl2.h                                    | 2 +-
>  include/acpi/actbl3.h                                    | 2 +-
>  include/acpi/actypes.h                                   | 2 +-
>  include/acpi/acuuid.h                                    | 2 +-
>  include/acpi/platform/acenv.h                            | 2 +-
>  include/acpi/platform/acenvex.h                          | 2 +-
>  include/acpi/platform/acgcc.h                            | 2 +-
>  include/acpi/platform/acgccex.h                          | 2 +-
>  include/acpi/platform/acintel.h                          | 2 +-
>  include/acpi/platform/aclinux.h                          | 2 +-
>  include/acpi/platform/aclinuxex.h                        | 2 +-
>  tools/power/acpi/common/cmfsize.c                        | 2 +-
>  tools/power/acpi/common/getopt.c                         | 2 +-
>  tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
>  tools/power/acpi/os_specific/service_layers/osunixdir.c  | 2 +-
>  tools/power/acpi/os_specific/service_layers/osunixmap.c  | 2 +-
>  tools/power/acpi/os_specific/service_layers/osunixxf.c   | 2 +-
>  tools/power/acpi/tools/acpidump/acpidump.h               | 2 +-
>  tools/power/acpi/tools/acpidump/apdump.c                 | 2 +-
>  tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
>  tools/power/acpi/tools/acpidump/apmain.c                 | 2 +-
>  174 files changed, 176 insertions(+), 176 deletions(-)

Both patches applies as 5.6 material, thanks!
