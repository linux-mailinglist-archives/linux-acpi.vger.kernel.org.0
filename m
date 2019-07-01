Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27ED91FC11
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2019 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfEOVHh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 May 2019 17:07:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44952 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfEOVHh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 May 2019 17:07:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id g18so1368623otj.11
        for <linux-acpi@vger.kernel.org>; Wed, 15 May 2019 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zEAiaEFTDEo5AHTXNi1igG//m3yl73MYATUt/TyQM/s=;
        b=JldDYW+LTAR5BoMmvzt3GhFBKSNFCQljO95A7CQF8h7lezT59wkCmoZR8HlZNeo3ZX
         ACz18is11PqZLJkpbZTbPrVApVsXuwCwQzpumDKhMYUGYyeEKSs4shc89Funjj7rmnrR
         zPCblVOMVW4B/FdfDdDBm0eQtlDpcEoDreFJYHB2TrhXh9porw+VCF0gkgtOPIdPF4AY
         hPK/m0cAXNVhKubNUJt+B+Ge41ks183CJ7yggGXayFgFqQhy+nfr59BSRoNiAIUor77P
         UmqXqpMAHdjAUWsPGhNLbi9iUpZ9FsKZwds3Nd3zmasJxQ+15Rm38l4yGAgNrmpf7grH
         OFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zEAiaEFTDEo5AHTXNi1igG//m3yl73MYATUt/TyQM/s=;
        b=G249EXeZdx+Z3pchumsmHHqDAxomMuYIP/xKO2xBNLHXgSeqgS1bU33rqhvSFPmIQm
         a2bSWQ4bKMHsSElxMci2kgETJpALaiLkslVblglzihm+PYMOeq2x16Cs/ITqR/X6+TmT
         K8tCMRNemWX9VIj1BgvLu/2AHUnayb1QZ/f8VWVDNuaJZiz9USa76L+oP0AKFhVdONgq
         9d6a9EKWq/B43Pmch3AOfEKeyVdOr9ZJw7JepnaaWk55weQVpmxsssYqVBlKhW00PiMj
         KZRbswLazZ0y7E8uaAMRVMBeQUP/hexmaYbJLWGaExwWqoIJh3KY+qK6BONZxSOaQUMc
         5W1A==
X-Gm-Message-State: APjAAAWkAKCNyIUZcLoy62y7TjZaZ56kVpPEvdSV1a06zWqUc15CX7z/
        Y/f7WaqnSqlAD5OidQH8C9mm7AmC4rNyYOz6DNs8QA==
X-Google-Smtp-Source: APXvYqyDA/EWUSXzmLh3QyRTwliJkHZQ726n1NRYV2Be3duzD6pV8jVLvRmpMo63mBrfvCQmmCONZIUwdUcOhHdo8aI=
X-Received: by 2002:a05:6830:14d3:: with SMTP id t19mr27993804otq.57.1557954454945;
 Wed, 15 May 2019 14:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190514145422.16923-1-pagupta@redhat.com> <20190514145422.16923-2-pagupta@redhat.com>
In-Reply-To: <20190514145422.16923-2-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 May 2019 14:07:23 -0700
Message-ID: <CAPcyv4gEr_zPJEQp3k89v2UXfHp9PQwnJXY+W99HwXfxpvua_w@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] libnvdimm: nd_region flush callback support
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM list <kvm@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@infradead.org>,
        Len Brown <lenb@kernel.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        david <david@fromorbit.com>, cohuck@redhat.com,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Adam Borowski <kilobyte@angband.pl>,
        yuval shaia <yuval.shaia@oracle.com>, jstaron@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 14, 2019 at 7:55 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds functionality to perform flush from guest
> to host over VIRTIO. We are registering a callback based
> on 'nd_region' type. virtio_pmem driver requires this special
> flush function. For rest of the region types we are registering
> existing flush function. Report error returned by host fsync
> failure to userspace.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/acpi/nfit/core.c     |  4 ++--
>  drivers/nvdimm/claim.c       |  6 ++++--
>  drivers/nvdimm/nd.h          |  1 +
>  drivers/nvdimm/pmem.c        | 13 ++++++++-----
>  drivers/nvdimm/region_devs.c | 26 ++++++++++++++++++++++++--
>  include/linux/libnvdimm.h    |  8 +++++++-
>  6 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5a389a4f4f65..08dde76cf459 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2434,7 +2434,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_blk=
, unsigned int bw,
>                 offset =3D to_interleave_offset(offset, mmio);
>
>         writeq(cmd, mmio->addr.base + offset);
> -       nvdimm_flush(nfit_blk->nd_region);
> +       nvdimm_flush(nfit_blk->nd_region, NULL);
>
>         if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
>                 readq(mmio->addr.base + offset);
> @@ -2483,7 +2483,7 @@ static int acpi_nfit_blk_single_io(struct nfit_blk =
*nfit_blk,
>         }
>
>         if (rw)
> -               nvdimm_flush(nfit_blk->nd_region);
> +               nvdimm_flush(nfit_blk->nd_region, NULL);
>
>         rc =3D read_blk_stat(nfit_blk, lane) ? -EIO : 0;
>         return rc;
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index fb667bf469c7..13510bae1e6f 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -263,7 +263,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *=
ndns,
>         struct nd_namespace_io *nsio =3D to_nd_namespace_io(&ndns->dev);
>         unsigned int sz_align =3D ALIGN(size + (offset & (512 - 1)), 512)=
;
>         sector_t sector =3D offset >> 9;
> -       int rc =3D 0;
> +       int rc =3D 0, ret =3D 0;
>
>         if (unlikely(!size))
>                 return 0;
> @@ -301,7 +301,9 @@ static int nsio_rw_bytes(struct nd_namespace_common *=
ndns,
>         }
>
>         memcpy_flushcache(nsio->addr + offset, buf, size);
> -       nvdimm_flush(to_nd_region(ndns->dev.parent));
> +       ret =3D nvdimm_flush(to_nd_region(ndns->dev.parent), NULL);
> +       if (ret)
> +               rc =3D ret;
>
>         return rc;
>  }
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index a5ac3b240293..0c74d2428bd7 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -159,6 +159,7 @@ struct nd_region {
>         struct badblocks bb;
>         struct nd_interleave_set *nd_set;
>         struct nd_percpu_lane __percpu *lane;
> +       int (*flush)(struct nd_region *nd_region, struct bio *bio);

So this triggers:

In file included from drivers/nvdimm/e820.c:7:
./include/linux/libnvdimm.h:140:51: warning: =E2=80=98struct bio=E2=80=99 d=
eclared
inside parameter list will not be visible outside of this definition
or declaration
  int (*flush)(struct nd_region *nd_region, struct bio *bio);
                                                   ^~~
I was already feeling uneasy about trying to squeeze this into v5.2,
but this warning and the continued drip of comments leads me to
conclude that this driver would do well to wait one more development
cycle. Lets close out the final fixups and let this driver soak in
-next. Then for the v5.3 cycle I'll redouble my efforts towards the
goal of closing patch acceptance at the -rc6 / -rc7 development
milestone.
