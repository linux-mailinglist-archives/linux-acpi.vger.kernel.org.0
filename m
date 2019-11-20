Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A117A10420C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKTR01 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Nov 2019 12:26:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37004 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727639AbfKTR01 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2019 12:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574270785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7t5VREsrL6wOeWEU8/Ixa0IaxMqmj2iSmqDhC9ITcg=;
        b=QYmK3XWaY2W/y2+HAJ3wleXYM340N/qS6uESXZCQm0Lf+ZbG/EUZgxS0xLEMwE0gIYT58T
        jCb8xtNgwDSaBoPYI+KBLC6mH5625Q51zK5jsnbxhyphLhWEkDnMK2rIiv3EBuCQLCP/TF
        HuG5L6yAczzVaZVFpnJC1cBhH/zZi2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-WBAaGR23OyO_4ZjwI9cbdA-1; Wed, 20 Nov 2019 12:26:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0A5F100550E;
        Wed, 20 Nov 2019 17:26:19 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77C885D6BE;
        Wed, 20 Nov 2019 17:26:18 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        vgoyal@redhat.com, keith.busch@intel.com
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
References: <20191120092831.6198-1-pagupta@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 20 Nov 2019 12:26:17 -0500
In-Reply-To: <20191120092831.6198-1-pagupta@redhat.com> (Pankaj Gupta's
        message of "Wed, 20 Nov 2019 14:58:31 +0530")
Message-ID: <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WBAaGR23OyO_4ZjwI9cbdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Pankaj Gupta <pagupta@redhat.com> writes:

>  Remove logic to create child bio in the async flush function which
>  causes child bio to get executed after parent bio 'pmem_make_request'
>  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
>  data write request.
>
>  Instead we are performing flush from the parent bio to maintain the
>  correct order. Also, returning from function 'pmem_make_request' if
>  REQ_PREFLUSH returns an error.
>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

There's a slight change in behavior for the error path in the
virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
converted to -EIO.  Now, they are reported as-is.  I think this is
actually an improvement.

I'll also note that the current behavior can result in data corruption,
so this should be tagged for stable.

The patch looks good to me.

Thanks!

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

> ---
>  drivers/acpi/nfit/core.c     |  4 ++--
>  drivers/nvdimm/claim.c       |  2 +-
>  drivers/nvdimm/nd.h          |  2 +-
>  drivers/nvdimm/nd_virtio.c   | 29 ++---------------------------
>  drivers/nvdimm/pmem.c        | 14 ++++++++++----
>  drivers/nvdimm/region_devs.c |  6 +++---
>  drivers/nvdimm/virtio_pmem.c |  2 +-
>  drivers/nvdimm/virtio_pmem.h |  2 +-
>  include/linux/libnvdimm.h    |  4 ++--
>  9 files changed, 23 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 14e68f202f81..afbd5e2b2ea8 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2426,7 +2426,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_blk=
, unsigned int bw,
>  =09=09offset =3D to_interleave_offset(offset, mmio);
> =20
>  =09writeq(cmd, mmio->addr.base + offset);
> -=09nvdimm_flush(nfit_blk->nd_region, NULL);
> +=09nvdimm_flush(nfit_blk->nd_region);
> =20
>  =09if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
>  =09=09readq(mmio->addr.base + offset);
> @@ -2475,7 +2475,7 @@ static int acpi_nfit_blk_single_io(struct nfit_blk =
*nfit_blk,
>  =09}
> =20
>  =09if (rw)
> -=09=09nvdimm_flush(nfit_blk->nd_region, NULL);
> +=09=09nvdimm_flush(nfit_blk->nd_region);
> =20
>  =09rc =3D read_blk_stat(nfit_blk, lane) ? -EIO : 0;
>  =09return rc;
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 2985ca949912..0fedb2fbfcbe 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -293,7 +293,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *=
ndns,
>  =09}
> =20
>  =09memcpy_flushcache(nsio->addr + offset, buf, size);
> -=09ret =3D nvdimm_flush(to_nd_region(ndns->dev.parent), NULL);
> +=09ret =3D nvdimm_flush(to_nd_region(ndns->dev.parent));
>  =09if (ret)
>  =09=09rc =3D ret;
> =20
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index ee5c04070ef9..77d8b9f0c34a 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -155,7 +155,7 @@ struct nd_region {
>  =09struct badblocks bb;
>  =09struct nd_interleave_set *nd_set;
>  =09struct nd_percpu_lane __percpu *lane;
> -=09int (*flush)(struct nd_region *nd_region, struct bio *bio);
> +=09int (*flush)(struct nd_region *nd_region);
>  =09struct nd_mapping mapping[0];
>  };
> =20
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 10351d5b49fa..9604ba08a68a 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -35,7 +35,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
>  EXPORT_SYMBOL_GPL(virtio_pmem_host_ack);
> =20
>   /* The request submission function */
> -static int virtio_pmem_flush(struct nd_region *nd_region)
> +int virtio_pmem_flush(struct nd_region *nd_region)
>  {
>  =09struct virtio_device *vdev =3D nd_region->provider_data;
>  =09struct virtio_pmem *vpmem  =3D vdev->priv;
> @@ -96,30 +96,5 @@ static int virtio_pmem_flush(struct nd_region *nd_regi=
on)
>  =09kfree(req_data);
>  =09return err;
>  };
> -
> -/* The asynchronous flush callback function */
> -int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> -{
> -=09/*
> -=09 * Create child bio for asynchronous flush and chain with
> -=09 * parent bio. Otherwise directly call nd_region flush.
> -=09 */
> -=09if (bio && bio->bi_iter.bi_sector !=3D -1) {
> -=09=09struct bio *child =3D bio_alloc(GFP_ATOMIC, 0);
> -
> -=09=09if (!child)
> -=09=09=09return -ENOMEM;
> -=09=09bio_copy_dev(child, bio);
> -=09=09child->bi_opf =3D REQ_PREFLUSH;
> -=09=09child->bi_iter.bi_sector =3D -1;
> -=09=09bio_chain(child, bio);
> -=09=09submit_bio(child);
> -=09=09return 0;
> -=09}
> -=09if (virtio_pmem_flush(nd_region))
> -=09=09return -EIO;
> -
> -=09return 0;
> -};
> -EXPORT_SYMBOL_GPL(async_pmem_flush);
> +EXPORT_SYMBOL_GPL(virtio_pmem_flush);
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index f9f76f6ba07b..b3ca641668a2 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -194,7 +194,13 @@ static blk_qc_t pmem_make_request(struct request_que=
ue *q, struct bio *bio)
>  =09struct nd_region *nd_region =3D to_region(pmem);
> =20
>  =09if (bio->bi_opf & REQ_PREFLUSH)
> -=09=09ret =3D nvdimm_flush(nd_region, bio);
> +=09=09ret =3D nvdimm_flush(nd_region);
> +
> +=09if (ret) {
> +=09=09bio->bi_status =3D errno_to_blk_status(ret);
> +=09=09bio_endio(bio);
> +=09=09return BLK_QC_T_NONE;
> +=09}
> =20
>  =09do_acct =3D nd_iostat_start(bio, &start);
>  =09bio_for_each_segment(bvec, bio, iter) {
> @@ -209,7 +215,7 @@ static blk_qc_t pmem_make_request(struct request_queu=
e *q, struct bio *bio)
>  =09=09nd_iostat_end(bio, start);
> =20
>  =09if (bio->bi_opf & REQ_FUA)
> -=09=09ret =3D nvdimm_flush(nd_region, bio);
> +=09=09ret =3D nvdimm_flush(nd_region);
> =20
>  =09if (ret)
>  =09=09bio->bi_status =3D errno_to_blk_status(ret);
> @@ -549,14 +555,14 @@ static int nd_pmem_remove(struct device *dev)
>  =09=09sysfs_put(pmem->bb_state);
>  =09=09pmem->bb_state =3D NULL;
>  =09}
> -=09nvdimm_flush(to_nd_region(dev->parent), NULL);
> +=09nvdimm_flush(to_nd_region(dev->parent));
> =20
>  =09return 0;
>  }
> =20
>  static void nd_pmem_shutdown(struct device *dev)
>  {
> -=09nvdimm_flush(to_nd_region(dev->parent), NULL);
> +=09nvdimm_flush(to_nd_region(dev->parent));
>  }
> =20
>  static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef423ba1a711..cfd96a0d52f2 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -287,7 +287,7 @@ static ssize_t deep_flush_store(struct device *dev, s=
truct device_attribute *att
>  =09=09return rc;
>  =09if (!flush)
>  =09=09return -EINVAL;
> -=09rc =3D nvdimm_flush(nd_region, NULL);
> +=09rc =3D nvdimm_flush(nd_region);
>  =09if (rc)
>  =09=09return rc;
> =20
> @@ -1079,14 +1079,14 @@ struct nd_region *nvdimm_volatile_region_create(s=
truct nvdimm_bus *nvdimm_bus,
>  }
>  EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
> =20
> -int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
> +int nvdimm_flush(struct nd_region *nd_region)
>  {
>  =09int rc =3D 0;
> =20
>  =09if (!nd_region->flush)
>  =09=09rc =3D generic_nvdimm_flush(nd_region);
>  =09else {
> -=09=09if (nd_region->flush(nd_region, bio))
> +=09=09if (nd_region->flush(nd_region))
>  =09=09=09rc =3D -EIO;
>  =09}
> =20
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 5e3d07b47e0c..a6234466674d 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -80,7 +80,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev=
)
> =20
>  =09ndr_desc.res =3D &res;
>  =09ndr_desc.numa_node =3D nid;
> -=09ndr_desc.flush =3D async_pmem_flush;
> +=09ndr_desc.flush =3D virtio_pmem_flush;
>  =09set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
>  =09set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
>  =09nd_region =3D nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc)=
;
> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> index 0dddefe594c4..4f9ee19aad90 100644
> --- a/drivers/nvdimm/virtio_pmem.h
> +++ b/drivers/nvdimm/virtio_pmem.h
> @@ -51,5 +51,5 @@ struct virtio_pmem {
>  };
> =20
>  void virtio_pmem_host_ack(struct virtqueue *vq);
> -int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> +int virtio_pmem_flush(struct nd_region *nd_region);
>  #endif
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index b6eddf912568..211c87edb4eb 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -130,7 +130,7 @@ struct nd_region_desc {
>  =09int target_node;
>  =09unsigned long flags;
>  =09struct device_node *of_node;
> -=09int (*flush)(struct nd_region *nd_region, struct bio *bio);
> +=09int (*flush)(struct nd_region *nd_region);
>  };
> =20
>  struct device;
> @@ -261,7 +261,7 @@ unsigned long nd_blk_memremap_flags(struct nd_blk_reg=
ion *ndbr);
>  unsigned int nd_region_acquire_lane(struct nd_region *nd_region);
>  void nd_region_release_lane(struct nd_region *nd_region, unsigned int la=
ne);
>  u64 nd_fletcher64(void *addr, size_t len, bool le);
> -int nvdimm_flush(struct nd_region *nd_region, struct bio *bio);
> +int nvdimm_flush(struct nd_region *nd_region);
>  int generic_nvdimm_flush(struct nd_region *nd_region);
>  int nvdimm_has_flush(struct nd_region *nd_region);
>  int nvdimm_has_cache(struct nd_region *nd_region);

