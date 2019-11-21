Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B4104ACE
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 07:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUGom (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 01:44:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42853 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbfKUGom (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Nov 2019 01:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574318677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMGWaxqnkVaeWUjlN+I1dGY1DIkk17keCIFSGgweILI=;
        b=FuelJZVWLHQjidQMAOuQNHPrYFXifYDKZy5nEHYnz0Hxaa7WlpaFIh0+zzGeeKXgicXrUW
        SHNGELePPD++zqPI41aGjwD4LvpDQq3Go7UY0u4VcJwHKVdVHXONG00gtzOQHytKpBm+j5
        R92MI/dwqaG2hjQcZtBDrikX7LSZ9EA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-ueyO9tQWPJmJBkUlngdxkg-1; Thu, 21 Nov 2019 01:44:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6380F1005509;
        Thu, 21 Nov 2019 06:44:32 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BBA16FEF8;
        Thu, 21 Nov 2019 06:44:32 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 09CB91809563;
        Thu, 21 Nov 2019 06:44:32 +0000 (UTC)
Date:   Thu, 21 Nov 2019 01:44:31 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        dan j williams <dan.j.williams@intel.com>,
        vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        ira weiny <ira.weiny@intel.com>, rjw@rjwysocki.net,
        lenb@kernel.org, vgoyal@redhat.com,
        keith busch <keith.busch@intel.com>
Message-ID: <2127035321.35801701.1574318671923.JavaMail.zimbra@redhat.com>
In-Reply-To: <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
MIME-Version: 1.0
X-Originating-IP: [10.67.116.169, 10.4.195.11]
Thread-Topic: virtio pmem: fix async flush ordering
Thread-Index: GhBRKXU2DrvEWMvmDLN5uRjo38ugBw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ueyO9tQWPJmJBkUlngdxkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


>=20
> >  Remove logic to create child bio in the async flush function which
> >  causes child bio to get executed after parent bio 'pmem_make_request'
> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> >  data write request.
> >
> >  Instead we are performing flush from the parent bio to maintain the
> >  correct order. Also, returning from function 'pmem_make_request' if
> >  REQ_PREFLUSH returns an error.
> >
> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>=20
> There's a slight change in behavior for the error path in the
> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> converted to -EIO.  Now, they are reported as-is.  I think this is
> actually an improvement.

yes.

>=20
> I'll also note that the current behavior can result in data corruption,
> so this should be tagged for stable.

Agree.

>=20
> The patch looks good to me.
>=20
> Thanks!
>=20
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Thank you!

Pankaj

>=20
> > ---
> >  drivers/acpi/nfit/core.c     |  4 ++--
> >  drivers/nvdimm/claim.c       |  2 +-
> >  drivers/nvdimm/nd.h          |  2 +-
> >  drivers/nvdimm/nd_virtio.c   | 29 ++---------------------------
> >  drivers/nvdimm/pmem.c        | 14 ++++++++++----
> >  drivers/nvdimm/region_devs.c |  6 +++---
> >  drivers/nvdimm/virtio_pmem.c |  2 +-
> >  drivers/nvdimm/virtio_pmem.h |  2 +-
> >  include/linux/libnvdimm.h    |  4 ++--
> >  9 files changed, 23 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 14e68f202f81..afbd5e2b2ea8 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -2426,7 +2426,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_b=
lk,
> > unsigned int bw,
> >                  offset =3D to_interleave_offset(offset, mmio);
> > =20
> >          writeq(cmd, mmio->addr.base + offset);
> > -        nvdimm_flush(nfit_blk->nd_region, NULL);
> > +        nvdimm_flush(nfit_blk->nd_region);
> > =20
> >          if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
> >                  readq(mmio->addr.base + offset);
> > @@ -2475,7 +2475,7 @@ static int acpi_nfit_blk_single_io(struct nfit_bl=
k
> > *nfit_blk,
> >          }
> > =20
> >          if (rw)
> > -                nvdimm_flush(nfit_blk->nd_region, NULL);
> > +                nvdimm_flush(nfit_blk->nd_region);
> > =20
> >          rc =3D read_blk_stat(nfit_blk, lane) ? -EIO : 0;
> >          return rc;
> > diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> > index 2985ca949912..0fedb2fbfcbe 100644
> > --- a/drivers/nvdimm/claim.c
> > +++ b/drivers/nvdimm/claim.c
> > @@ -293,7 +293,7 @@ static int nsio_rw_bytes(struct nd_namespace_common
> > *ndns,
> >          }
> > =20
> >          memcpy_flushcache(nsio->addr + offset, buf, size);
> > -        ret =3D nvdimm_flush(to_nd_region(ndns->dev.parent), NULL);
> > +        ret =3D nvdimm_flush(to_nd_region(ndns->dev.parent));
> >          if (ret)
> >                  rc =3D ret;
> > =20
> > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > index ee5c04070ef9..77d8b9f0c34a 100644
> > --- a/drivers/nvdimm/nd.h
> > +++ b/drivers/nvdimm/nd.h
> > @@ -155,7 +155,7 @@ struct nd_region {
> >          struct badblocks bb;
> >          struct nd_interleave_set *nd_set;
> >          struct nd_percpu_lane __percpu *lane;
> > -        int (*flush)(struct nd_region *nd_region, struct bio *bio);
> > +        int (*flush)(struct nd_region *nd_region);
> >          struct nd_mapping mapping[0];
> >  };
> > =20
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > index 10351d5b49fa..9604ba08a68a 100644
> > --- a/drivers/nvdimm/nd_virtio.c
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -35,7 +35,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
> >  EXPORT_SYMBOL_GPL(virtio_pmem_host_ack);
> > =20
> >   /* The request submission function */
> > -static int virtio_pmem_flush(struct nd_region *nd_region)
> > +int virtio_pmem_flush(struct nd_region *nd_region)
> >  {
> >          struct virtio_device *vdev =3D nd_region->provider_data;
> >          struct virtio_pmem *vpmem  =3D vdev->priv;
> > @@ -96,30 +96,5 @@ static int virtio_pmem_flush(struct nd_region
> > *nd_region)
> >          kfree(req_data);
> >          return err;
> >  };
> > -
> > -/* The asynchronous flush callback function */
> > -int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > -{
> > -        /*
> > -         * Create child bio for asynchronous flush and chain with
> > -         * parent bio. Otherwise directly call nd_region flush.
> > -         */
> > -        if (bio && bio->bi_iter.bi_sector !=3D -1) {
> > -                struct bio *child =3D bio_alloc(GFP_ATOMIC, 0);
> > -
> > -                if (!child)
> > -                        return -ENOMEM;
> > -                bio_copy_dev(child, bio);
> > -                child->bi_opf =3D REQ_PREFLUSH;
> > -                child->bi_iter.bi_sector =3D -1;
> > -                bio_chain(child, bio);
> > -                submit_bio(child);
> > -                return 0;
> > -        }
> > -        if (virtio_pmem_flush(nd_region))
> > -                return -EIO;
> > -
> > -        return 0;
> > -};
> > -EXPORT_SYMBOL_GPL(async_pmem_flush);
> > +EXPORT_SYMBOL_GPL(virtio_pmem_flush);
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index f9f76f6ba07b..b3ca641668a2 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -194,7 +194,13 @@ static blk_qc_t pmem_make_request(struct request_q=
ueue
> > *q, struct bio *bio)
> >          struct nd_region *nd_region =3D to_region(pmem);
> > =20
> >          if (bio->bi_opf & REQ_PREFLUSH)
> > -                ret =3D nvdimm_flush(nd_region, bio);
> > +                ret =3D nvdimm_flush(nd_region);
> > +
> > +        if (ret) {
> > +                bio->bi_status =3D errno_to_blk_status(ret);
> > +                bio_endio(bio);
> > +                return BLK_QC_T_NONE;
> > +        }
> > =20
> >          do_acct =3D nd_iostat_start(bio, &start);
> >          bio_for_each_segment(bvec, bio, iter) {
> > @@ -209,7 +215,7 @@ static blk_qc_t pmem_make_request(struct request_qu=
eue
> > *q, struct bio *bio)
> >                  nd_iostat_end(bio, start);
> > =20
> >          if (bio->bi_opf & REQ_FUA)
> > -                ret =3D nvdimm_flush(nd_region, bio);
> > +                ret =3D nvdimm_flush(nd_region);
> > =20
> >          if (ret)
> >                  bio->bi_status =3D errno_to_blk_status(ret);
> > @@ -549,14 +555,14 @@ static int nd_pmem_remove(struct device *dev)
> >                  sysfs_put(pmem->bb_state);
> >                  pmem->bb_state =3D NULL;
> >          }
> > -        nvdimm_flush(to_nd_region(dev->parent), NULL);
> > +        nvdimm_flush(to_nd_region(dev->parent));
> > =20
> >          return 0;
> >  }
> > =20
> >  static void nd_pmem_shutdown(struct device *dev)
> >  {
> > -        nvdimm_flush(to_nd_region(dev->parent), NULL);
> > +        nvdimm_flush(to_nd_region(dev->parent));
> >  }
> > =20
> >  static void nd_pmem_notify(struct device *dev, enum nvdimm_event event=
)
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.=
c
> > index ef423ba1a711..cfd96a0d52f2 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -287,7 +287,7 @@ static ssize_t deep_flush_store(struct device *dev,
> > struct device_attribute *att
> >                  return rc;
> >          if (!flush)
> >                  return -EINVAL;
> > -        rc =3D nvdimm_flush(nd_region, NULL);
> > +        rc =3D nvdimm_flush(nd_region);
> >          if (rc)
> >                  return rc;
> > =20
> > @@ -1079,14 +1079,14 @@ struct nd_region
> > *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
> >  }
> >  EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
> > =20
> > -int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
> > +int nvdimm_flush(struct nd_region *nd_region)
> >  {
> >          int rc =3D 0;
> > =20
> >          if (!nd_region->flush)
> >                  rc =3D generic_nvdimm_flush(nd_region);
> >          else {
> > -                if (nd_region->flush(nd_region, bio))
> > +                if (nd_region->flush(nd_region))
> >                          rc =3D -EIO;
> >          }
> > =20
> > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.=
c
> > index 5e3d07b47e0c..a6234466674d 100644
> > --- a/drivers/nvdimm/virtio_pmem.c
> > +++ b/drivers/nvdimm/virtio_pmem.c
> > @@ -80,7 +80,7 @@ static int virtio_pmem_probe(struct virtio_device *vd=
ev)
> > =20
> >          ndr_desc.res =3D &res;
> >          ndr_desc.numa_node =3D nid;
> > -        ndr_desc.flush =3D async_pmem_flush;
> > +        ndr_desc.flush =3D virtio_pmem_flush;
> >          set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> >          set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> >          nd_region =3D nvdimm_pmem_region_create(vpmem->nvdimm_bus, &nd=
r_desc);
> > diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.=
h
> > index 0dddefe594c4..4f9ee19aad90 100644
> > --- a/drivers/nvdimm/virtio_pmem.h
> > +++ b/drivers/nvdimm/virtio_pmem.h
> > @@ -51,5 +51,5 @@ struct virtio_pmem {
> >  };
> > =20
> >  void virtio_pmem_host_ack(struct virtqueue *vq);
> > -int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> > +int virtio_pmem_flush(struct nd_region *nd_region);
> >  #endif
> > diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> > index b6eddf912568..211c87edb4eb 100644
> > --- a/include/linux/libnvdimm.h
> > +++ b/include/linux/libnvdimm.h
> > @@ -130,7 +130,7 @@ struct nd_region_desc {
> >          int target_node;
> >          unsigned long flags;
> >          struct device_node *of_node;
> > -        int (*flush)(struct nd_region *nd_region, struct bio *bio);
> > +        int (*flush)(struct nd_region *nd_region);
> >  };
> > =20
> >  struct device;
> > @@ -261,7 +261,7 @@ unsigned long nd_blk_memremap_flags(struct
> > nd_blk_region *ndbr);
> >  unsigned int nd_region_acquire_lane(struct nd_region *nd_region);
> >  void nd_region_release_lane(struct nd_region *nd_region, unsigned int
> >  lane);
> >  u64 nd_fletcher64(void *addr, size_t len, bool le);
> > -int nvdimm_flush(struct nd_region *nd_region, struct bio *bio);
> > +int nvdimm_flush(struct nd_region *nd_region);
> >  int generic_nvdimm_flush(struct nd_region *nd_region);
> >  int nvdimm_has_flush(struct nd_region *nd_region);
> >  int nvdimm_has_cache(struct nd_region *nd_region);
>=20

